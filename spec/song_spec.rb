require 'spec_helper'

describe 'Song' do

    describe '#==' do
        it 'is the same song if it has the same attributes as another song' do
            song1 = Song.new({name: 'Naima', album_id: 1})
            song2 = Song.new({name: 'Naima', album_id: 1})
            expect(song1).to eq(song2)
        end
    end
    describe '#save' do
        it 'saves a song' do
            song = Song.new({name: 'Naima', album_id: 1}).save
            expect(Song.all).to eq([song])
        end
    end
    describe '#update' do
        it 'updates an song by id' do
            song = Song.new({name: 'Naima', album_id: 1}).save
            song.update({name: 'Mr. P.C.', album_id: 2})
            expect(song.name).to eq('Mr. P.C.')
        end
    end
    describe '#delete' do
        it 'deletes an song by id' do
            song1 = Song.new({name: 'Giant Steps', album_id: 1}).save
            song2 = Song.new({name: 'Naima', album_id: 1}).save
            song2.delete
            expect(Song.all).to include(song1)
            expect(Song.all).not_to include(song2)
        end
    end
    describe '#album' do
        it 'finds the album a song belongs to' do
            album = Album.new({name: 'Giant Steps'}).save
            song = Song.new({name: 'Naima', album_id: album.id}).save
            expect(song.album).to eq(album)
        end
    end

    describe '.all' do
        it 'returns a list of all songs' do
            song1 = Song.new({name: 'Giant Steps', album_id: 1}).save
            song2 = Song.new({name: 'Naima', album_id: 1}).save
            expect(Song.all).to include(song1, song2)
        end
    end
    describe '.clear' do
        it 'clears all songs' do
            song1 = Song.new({name: 'Giant Steps', album_id: 1}).save
            song2 = Song.new({name: 'Naima', album_id: 1}).save
            Song.clear
            expect(Song.all).to eq([])
        end
    end
    describe '.find' do
        it 'finds a song by id' do
            song1 = Song.new({name: 'Giant Steps', album_id: 1}).save
            song2 = Song.new({name: 'Naima', album_id: 1}).save
            expect(Song.find(song1.id)).to eq(song1)
        end
    end
    describe '.find_by_album' do
        it 'finds songs for an album' do
            album1 = Album.new({name: 'Kind Of Blue'}).save
            album2 = Album.new({name: 'Giant Steps'}).save
            song1 = Song.new({name: 'So What', album_id: album1.id}).save
            song2 = Song.new({name: 'Naima', album_id: album2.id}).save
            expect(Song.find_by_album(album2.id)).to include(song2)
        end
    end
end
