require 'rspec'
require 'album'
require 'song'

describe 'Album' do
    before(:each) do
        Album.clear()
        @album1 = Album.new("Giant Steps", 1960, "Jazz", "John Coltrane").save
        @album2 = Album.new("Fashion Nugget").save
        @album3 = Album.new("Cornbread").save
    end

    describe('#save') do
        it("saves an album") do
            album4 = Album.new("Cornbread").save
            expect(Album.all).to(eq([@album1, @album2, @album3, album4]))
        end
    end
    describe('#update') do
        it("updates an album by id") do
            @album3.update({name: "Kind of Blue"})
            expect(@album3.name).to(eq("Kind of Blue"))
        end
    end
    describe('#delete') do
        it("deletes an album by id") do
            @album1.delete
            expect(Album.all).to(eq([@album2, @album3]))
        end
    end
    describe('#sell') do
        it('deletes album and adds it to sold albums') do
            @album1.sell
            expect(Album.all).to(eq([@album2, @album3]))
            expect(Album.sold).to(eq([@album1]))
        end
    end
    describe('.clear') do
        it("clears all albums") do
            Album.clear
            expect(Album.all).to(eq([]))
        end
    end
    describe('.find') do
        it("finds an album by id") do
            expect(Album.find(@album1.id)).to(eq(@album1))
        end
    end
    describe('.search') do
        it("searches an album by name") do
            alb = Album.search(:name, "giant")
            expect(alb.name).to(eq("Giant Steps"))
            expect(alb.year).to(eq(1960))
            expect(alb.genre).to(eq("Jazz"))
            expect(alb.artist).to(eq("John Coltrane"))
        end
    end
    describe('.sort') do
        it("sorts all albums by name in alphebetical order") do
            expect(Album.sort[0].name).to(eq('Cornbread'))
        end
    end

    describe('#songs') do
        it("returns an album's songs") do
            song1 = Song.new("Naima", @album1.id).save
            song2 = Song.new("Cousin Mary", @album1.id).save
            expect(@album1.songs).to(eq([song1, song2]))
        end
    end
end
