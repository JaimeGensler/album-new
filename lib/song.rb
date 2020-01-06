class Song
    attr_reader :id
    attr_accessor :name, :album_id

    def initialize(attributes)
        @name = attributes[:name]
        @album_id = attributes[:album_id]
        @id = attributes[:id]
    end

    def save
        @id = DB.exec("INSERT INTO songs (name, album_id) VALUES ('#{@name}', #{@album_id}) RETURNING id;").first.fetch("id").to_i
        self
    end
    def update(new_attrs)
        @name = new_attrs[:name]
        @album_id = new_attrs[:album_id]
        DB.exec("UPDATE songs SET name = '#{@name}', album_id = #{@album_id} WHERE id = #{@id};")
    end
    def delete
        DB.exec("DELETE FROM songs WHERE id = #{@id};")
    end
    def ==(compare)
        (@name == compare.name) && (@album_id == compare.album_id)
    end

    def self.all
        DB.exec("SELECT * FROM songs;").map do |song|
            attributes = keys_to_sym(song)
            Song.new(attributes)
        end
    end
    def self.find(id)
        song = self.keys_to_sym(DB.exec("SELECT * FROM songs WHERE id = #{id};").first)
        song[:id] = song[:id].to_i
        song[:album_id] = song[:album_id].to_i
        Song.new(song)
    end
    def self.clear
        DB.exec("DELETE FROM songs *;")
    end
    def self.find_by_album(alb_id)
        DB.exec("SELECT * FROM songs WHERE album_id = #{alb_id};").map do |song|
            attributes = self.keys_to_sym(song)
            attributes[:id] = song[:id].to_i
            song[:album_id] = song[:album_id].to_i
            Song.new(attributes)
        end
    end

    def album
        Album.find(@album_id)
    end

    private
    def self.keys_to_sym(str_hash)
        str_hash.reduce({}) do |acc, (key, val)|
            acc[key.to_sym] = (['id', 'album_id'].include? key) ? val.to_i : val
            acc
        end
    end
end