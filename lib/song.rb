class Song
    attr_reader :id
    attr_accessor :name, :album_id

    def initialize(name, album_id)
        @name = name
        @album_id = album_id
        @id = (@@total_rows += 1)
    end

    def save
        @@songs[@id] = self
    end

    def update(new_vals)
        new_vals.each { |(key, val)| send("#{key}=".to_sym, (val == "") ? send(key) : val ) }
        self
    end

    def delete
        @@songs.delete(@id)
    end

    def album
        Album.find(@album_id)
    end

    #class methods
    @@songs = {}
    @@total_rows = 0

    def self.all
        @@songs.values
    end

    def self.find(id)
        @@songs[id]
    end

    def self.clear
        @@songs = {}
    end

    def self.find_by_album(alb_id)
        @@songs.values.select {|song| song.album_id == alb_id }
    end
end
