require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: 'sqlite3', database: 'barbershop.db'}

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

before do
	@barbers = Barber.all
end  

get '/' do
	@barbers = Barber.order "created_at DESC"
	erb :index		
end

get '/visit' do
  erb :visit
 end

 post '/visit' do
  
  c = Client.new params[:client]
  c.save
  
    
  @tytle = 'Thank you!'
  @message = "Dear #{@user_name}, we're wait you at #{@date_time} to barber #{@barber}, your color #{@color}"


    erb :message
end 
