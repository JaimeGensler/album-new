class Artist
    attr_accessor :name
    attr_reader :id
    def initialize(attributes)
        @name = attributes[:name]
        @id = attributes[:id]
    end
    def save
        @id = DB.exec("INSERT INTO artists (name) VALUES ('#{@name}') RETURNING id;").first.fetch("id").to_i
        self
    end
    def update(attributes)
        unless attributes[:name].nil?
            @name = attributes[:name]
            DB.exec("UPDATE artists SET name = '#{@name}' WHERE id = #{@id};")
        end
        unless attributes[:album_name].nil?
            album = DB.exec("SELECT * FROM albums WHERE lower(name)='#{attributes[:album_name].downcase}';").first
            unless album.nil?
                DB.exec("INSERT INTO albums_artists (album_id, artist_id) VALUES (#{album['id'].to_i}, #{@id});")
            end
        end
    end
    def delete
        DB.exec("DELETE FROM albums_artists WHERE artist_id = #{@id};")
        DB.exec("DELETE FROM artists WHERE id = #{@id};")
    end
    def albums
        DB.exec("SELECT album_id FROM albums_artists WHERE artist_id = #{@id};").map do |result|
            album_id = result["album_id"].to_i
            name = DB.exec("SELECT * FROM albums WHERE id = #{album_id};").first['name']
            Album.new({name: name, id: album_id})
        end
    end
    def ==(compare)
        (@name == compare.name) && (@id == compare.id)
    end

    #class methods
    def self.all
        DB.exec("SELECT * FROM artists;").map { |art| Artist.new(self.keys_to_sym(art)) }
    end
    def self.clear
        DB.exec("DELETE FROM artists *;")
    end
    def self.find(search_id)
        attributes = DB.exec("SELECT * FROM artists WHERE id = #{search_id};").first
        Artist.new(self.keys_to_sym(attributes))
    end

    private
    def self.keys_to_sym(str_hash)
        str_hash.reduce({}) do |acc, (key, val)|
            acc[key.to_sym] = (['id'].include? key) ? val.to_i : val
            acc
        end
    end
end
