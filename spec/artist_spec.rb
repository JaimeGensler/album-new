require 'spec_helper.rb'

describe 'Artist' do
    describe '#==' do
        it 'compares for equality' do
            artist1 = Artist.new({name: 'Cornbread'})
            artist2 = Artist.new({name: 'Cornbread'})
            expect(artist1 == artist2).to eq(true)
        end
    end
    describe '#save' do
        it 'saves an Artist' do
            artist = Artist.new({name: 'Cornbread'}).save
            expect(Artist.all).to include(artist)
        end
    end
    describe '#update' do
        it 'adds an album to an artist' do
            artist = Artist.new({name: 'John Coltrane'}).save
            album = Album.new({name: 'A Love Supreme'}).save
            artist.update({album_name: 'A Love Supreme'})
            expect(artist.albums).to include(album)
        end
    end
    describe '#delete' do
        it 'deletes an Artist by id and all songs belong to Artist' do
            artist = Artist.new({name: 'Cornbread'}).save
            artist.delete
            expect(Artist.all).not_to include(artist)
        end
    end
    describe '.all' do
        it 'returns a list of all Artists' do
            expect(Artist.all).to eq([])
        end
    end
    describe '.clear' do
        it 'clears all Artists' do
            Artist.clear
            expect(Artist.all).to eq([])
        end
    end
    describe '.find' do
        it 'finds an Artist by id' do
            artist = Artist.new({name: 'Cornbread'}).save
            expect(Artist.find(artist.id)).to eq(artist)
        end
    end
end
