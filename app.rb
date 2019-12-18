require 'sinatra'
require 'sinatra/reloader'
require './lib/album'
require './lib/song'
require 'pry'
also_reload 'lib/**/*.rb'

get('/') do
    @albums = Album.all
    @sold = Album.sold
    erb(:albums)
end

get('/albums') do
    @albums = Album.all
    @sold = Album.sold
    erb(:albums)
end
post('/albums') do
    @album = Album.new(*params.values).save
    @albums = Album.all
    @sold = Album.sold
    erb(:albums)
end
patch('/albums') do
    @album = Album.search(:id, params[:buyme]).sell
    @sold = Album.sold
    @albums = Album.all
    erb(:albums)
end

get('/albums/new') do
    erb(:albums_new)
end

get('/albums/:id') do
    @album = Album.search(:id, params[:id])
    erb(:albums_ID)
end
patch('/albums/:id') do
    album = Album.search(:id, params[:id])
    params.delete(:_method)
    params.delete(:id)
    album.update(params)
    @albums = Album.all
    @sold = Album.sold
    erb(:albums)
end
delete('/albums/:id') do
    @album = Album.find(params[:id].to_i).delete
    @albums = Album.all
    @sold = Album.sold
    erb(:albums)
end

get('/albums/:id/edit') do
    @album = Album.search(:id, params[:id])
    erb(:albums_ID_edit)
end

#////////////////// Songs routes /////////////////////
post('/albums/:id/songs') do
    @album = Album.find(params[:id].to_i)
    Song.new(params[:song_name], @album.id).save
    erb(:albums_ID)
end

get('/albums/:id/songs/:song_id') do
    @song = Song.find(params[:song_id].to_i)
    erb(:album_ID_song_ID)
end
patch('/albums/:id/songs/:song_id') do
    @album = Album.find(params[:id].to_i)
    song = Song.find(params[:song_id].to_i)
    params.delete(:_method)
    params.delete(:id)
    params.delete(:song_id)
    song.update(params)
    erb(:albums_ID)
end

delete('/albums/:id/songs/:song_id') do
    Song.find(params[:song_id].to_i).delete
    @album = Album.find(params[:id].to_i)
    erb(:albums_ID)
end
