require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/my_data.db")

class Poster
	include DataMapper::Resource
	property :id, Serial
	property :content, Text , required: true 
end

DataMapper.finalize.auto_upgrade!

get '/' do
	@first_post = Poster.all
	erb :home
end

post '/home' do
	@data = Poster.new
	@data.content = params[:message]
	@data.save

	redirect '/'
end