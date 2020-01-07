class Album
    attr_accessor :name, :year, :genre, :artist, :id
    def initialize(attributes)
        @name = attributes[:name]
        # @year = attributes[:year]
        # @genre = attributes[:genre]
        # @artist = attributes[:artist]
        @id = attributes[:id]
    end
    def save
        @id = DB.exec("INSERT INTO albums (name) VALUES ('#{@name}') RETURNING id;").first.fetch("id").to_i
        self
    end
    def update(new_attrs)
        @name = new_attrs[:name]
        # @year = new_attrs[:year]
        # @genre = new_attrs[:genre]
        # @artist = new_attrs[:artist]
        DB.exec("UPDATE albums SET name = '#{@name}' WHERE id = #{@id};")
        # DB.exec("UPDATE albums SET year = '#{@year}' WHERE id = #{@id};")
        # DB.exec("UPDATE albums SET genre = '#{@genre}' WHERE id = #{@id};")
        # DB.exec("UPDATE albums SET artist = '#{@artist}' WHERE id = #{@id};")
    end
    def delete
        DB.exec("DELETE FROM albums WHERE id = #{@id};")
        DB.exec("DELETE FROM songs WHERE album_id = #{@id};")
    end
    def songs
      Song.find_by_album(@id)
    end
    def ==(compare)
        (@name == compare.name) && (@year == compare.year) && (@genre == compare.genre) && (@artist == compare.artist)
    end

    #class methods
    def self.all
        DB.exec("SELECT * FROM albums;").map { |album| Album.new(self.keys_to_sym(album)) }
    end
    def self.clear
        DB.exec("DELETE FROM albums *;")
    end
    def self.find(search_id)
        attributes = DB.exec("SELECT * FROM albums WHERE id = #{search_id};").first
        Album.new(self.keys_to_sym(attributes))
    end

    private
    def self.keys_to_sym(str_hash)
        str_hash.reduce({}) do |acc, (key, val)|
            acc[key.to_sym] = (['id'].include? key) ? val.to_i : val
            acc
        end
    end
end
