class Album
    attr_accessor :name, :year, :genre, :artist, :id
    def initialize(name, year = nil, genre = nil, artist = nil)
        @name = name
        @year = year
        @genre = genre
        @artist = artist
        @id = (@@total_rows += 1)
    end

    def save
        @@albums[@id] = self
    end

    def update(new_vals)
        new_vals.each { |(key, val)| send("#{key}=".to_sym, (val == "") ? send(key) : val ) }
        self
    end

    def delete
        @@albums.delete(@id)
    end

    def sell
        delete
        @@sold_albums[@id] = self
    end

    #class methods
    @@albums = {}
    @@sold_albums = {}
    @@total_rows = 0

    def self.all
        @@albums.values
    end
    def self.sold
        @@sold_albums.values
    end

    def self.clear
        @@albums = {}
        @@total_rows = 0
    end

    def self.find(id)
        @@albums[id]
    end

    def self.search(type, term)
        @@albums.merge(@@sold_albums).values.select {|al| al.send(type).to_s.downcase.include? term.downcase}[0]
    end

    def self.sort()
        @@albums.values.sort {|a, b| a.name <=> b.name}
    end

    def songs
        Song.find_by_album(@id)
    end
end
