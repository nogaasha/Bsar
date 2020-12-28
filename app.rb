require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: 'sqlite3', database: 'barbershop.db'}

class Client < ActiveRecord::Base

  validates :name,  presence: true , length: { minimum: 3 }
  validates :phone,  presence: true 
  validates :datestamp,  presence: true 
  validates :color,  presence: true 
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
  @c = Client.new
  erb :visit
 end

post '/visit' do
  @c = Client.new params[:client]
  if @c.save
    
    @message = 'Вы  записались'
    erb :message
  else  
    @error = @c.errors.full_messages.first
    erb:visit
  end  
end 

get '/barber/:id' do
  @barber = Barber.find(params[:id])
  erb :barber
end  
