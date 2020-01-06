require 'sinatra'
require 'sinatra/reloader'
require './lib/album'
require './lib/song'
require 'pry'
require 'pg'

DB = PG.connect({:dbname => "record_store"})
also_reload 'lib/**/*.rb'

get '/' do
    redirect to '/albums'
end

get '/albums' do
    @albums = Album.all
    erb :albums
end
post '/albums' do
    Album.new(params)
    redirect to '/albums'
end

get '/albums/new' do
    erb :albums_new
end

get '/albums/:id' do
    @album = Album.search(:id, params[:id])
    erb :albums_ID
end
patch '/albums/:id' do
    Album.search(:id, params[:id]).update(params)
    redirect to '/albums/:id'
end
delete '/albums/:id' do
    Album.find(params[:id].to_i).delete
    redirect to '/albums'
end

get '/albums/:id/edit' do
    @album = Album.search(:id, params[:id])
    erb(:albums_ID_edit)
end

#////////////////// Songs routes /////////////////////
post '/albums/:id/songs' do
    params[:album_id] = Album.find(params[:id].to_i).id
    Song.new(params).save
    redirect to '/albums/:id'
end

get '/albums/:id/songs/:song_id' do
    @song = Song.find(params[:song_id].to_i)
    erb :album_ID_song_ID
end
patch '/albums/:id/songs/:song_id' do
    Song.find(params[:song_id].to_i).update(params)
    redirect to '/albums/:id/songs/:song_id'
end

delete('/albums/:id/songs/:song_id') do
    Song.find(params[:song_id].to_i).delete
    @album = Album.find(params[:id].to_i)
    erb(:albums_ID)
end
