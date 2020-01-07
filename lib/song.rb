class Song
    attr_reader :id
    attr_accessor :name, :album_id

    def initialize(attributes)
        @name = attributes[:name]
        @album_id = attributes[:album_id].to_i
        @id = attributes[:id].to_i
    end

    def save
        @id = DB.exec("INSERT INTO songs (name, album_id) VALUES ('#{@name}', #{@album_id}) RETURNING id;").first.fetch("id").to_i
        self
    end
    def update(new_attrs)
        @name = new_attrs[:name]
        @album_id = new_attrs[:album_id]
        DB.exec("UPDATE songs SET name = '#{@name}' WHERE id = #{@id};")
    end
    def delete
        DB.exec("DELETE FROM songs WHERE id = #{@id};")
    end
    def ==(compare)
        return false if (compare.nil?)
        (@name == compare.name) && (@album_id == compare.album_id)
    end

    def self.all
        DB.exec("SELECT * FROM songs;").map do |song|
            attributes = self.keys_to_sym(song)
            Song.new(attributes)
        end
    end
    def self.find(search_id)
        song = DB.exec("SELECT * FROM songs WHERE id = #{search_id};").first
        return nil if (song.nil?)
        Song.new(self.keys_to_sym(song))
    end
    def self.clearss
        DB.exec("DELETE FROM songs *;")
    end
    def self.find_by_album(alb_id)
        DB.exec("SELECT * FROM songs WHERE album_id = #{alb_id};").map do |song|
            attributes = self.keys_to_sym(song)
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
