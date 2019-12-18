require 'rspec'
require 'song'
require 'album'
require 'pry'

describe '#Song' do
    before(:each) do
        Album.clear()
        Song.clear()
        @album = Album.new("Giant Steps").save
        @song1 = Song.new("Giant Steps", @album.id).save
        @song2 = Song.new("Naima", @album.id).save
    end

    describe('#save') do
        it("saves a song") do
            expect(Song.all).to(eq([@song1, @song2]))
        end
    end
    describe('#update') do
        it("updates a song by id") do
            @song1.update( {name: "Mr. P.C."} )
            expect(@song1.name).to(eq("Mr. P.C."))
        end
    end
    describe("#delete") do
        it("deletes a song") do
            @song1.delete
            expect(Song.all).to(eq([@song2]))
        end
    end
    describe('#album') do
        it("finds the album a song belongs to") do
            expect(@song1.album).to(eq(@album))
        end
    end
    describe('.all') do
        it("returns a list of all songs") do
            expect(Song.all).to(eq([@song1, @song2]))
        end
    end
    describe('.clear') do
        it("clears all songs") do
            Song.clear()
            expect(Song.all).to(eq([]))
        end
    end
    describe('.find') do
        it("finds a song by id") do
            expect(Song.find(@song1.id)).to(eq(@song1))
        end
    end
    describe('.find_by_album') do
        it("finds songs for an album") do
            song3 = Song.new("Cornbread", nil).save
            expect(Song.find_by_album(@album.id)).to(eq([@song1, @song2]))
        end
    end
end
