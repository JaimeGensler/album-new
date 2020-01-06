require 'spec_helper.rb'

describe 'Album' do
    describe '#==' do
        it 'compares for equality' do
            album1 = Album.new({name: 'Cornbread'})
            album2 = Album.new({name: 'Cornbread'})
            expect(album1 == album2).to eq(true)
        end
    end
    describe '#save' do
        it 'saves an album' do
            album = Album.new({name: 'Cornbread'}).save
            expect(Album.all).to include(album)
        end
    end
    describe '#update' do
        it 'updates an album by id' do
            album = Album.new({name: 'Cornbard'}).save
            album.update({name: 'Cornbread'})
            expect(album.name).to eq('Cornbread')
        end
    end
    describe '#delete' do
        it 'deletes an album by id' do
            album = Album.new({name: 'Cornbread'}).save
            album.delete
            expect(Album.all).not_to include(album)
        end
    end
    # describe('#songs') do
    #     it("returns an album's songs") do
    #         song1 = Song.new("Naima", @album1.id).save
    #         song2 = Song.new("Cousin Mary", @album1.id).save
    #         expect(@album1.songs).to(eq([song1, song2]))
    #     end
    # end
    describe '.all' do
        it 'returns a list of all albums' do
            expect(Album.all).to eq([])
        end
    end
    describe '.clear' do
        it 'clears all albums' do
            Album.clear
            expect(Album.all).to eq([])
        end
    end
    describe '.find' do
        it 'finds an album by id' do
            album = Album.new({name: 'Cornbread'}).save
            expect(Album.find(album.id)).to eq(album)
        end
    end
    # describe('.search') do
    #     it("searches an album by name") do
    #         alb = Album.search(:name, "giant")
    #         expect(alb.name).to(eq("Giant Steps"))
    #         expect(alb.year).to(eq(1960))
    #         expect(alb.genre).to(eq("Jazz"))
    #         expect(alb.artist).to(eq("John Coltrane"))
    #     end
    # end
    # describe('.sort') do
    #     it("sorts all albums by name in alphebetical order") do
    #         expect(Album.sort[0].name).to(eq('Cornbread'))
    #     end
    # end
end