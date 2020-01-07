require 'capybara/rspec'
require './app'
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe 'create an album path', {:type => :feature} do
    it 'creates an album and then goes to the album page' do
        visit('/albums')
        click_on('Add a new album')
        fill_in('name', :with => 'Yellow Submarine')
        click_on('Go!')
        expect(page).to have_content('Yellow Submarine')
    end
end

describe 'create a song path', {:type => :feature} do
    it 'creates an album and then goes to the album page' do
        album = Album.new({name: "Yellow Submarine"}).save
        visit("/albums/#{album.id}")
        fill_in('name', :with => 'All You Need Is Love')
        click_on('Add song')
        expect(page).to have_content('All You Need Is Love')
    end
end

describe 'create an album path', {:type => :feature} do
    it 'creates an album and then goes to the album page' do
        visit('/albums')
        save_and_open_page
        click_on('Add a new album')
        fill_in('name', :with => 'Yellow Submarine')
        click_on('Go!')
        expect(page).to have_content('Yellow Submarine')
    end
end
