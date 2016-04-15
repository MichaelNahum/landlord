require 'sinatra'
require 'sinatra/reloader'
require 'active_record'

require "pg"
require "active_record"
require "pry"

require_relative "db/connection"
require_relative "models/apartment"
require_relative "models/tenant"

get "/" do
  "heyyy"
  erb :"home"
end

get "/apartments" do
  @apartment = Apartment.all
  erb :"apartment/index"
end

get '/apartment/new' do
  erb :'apartment/new'
end

post '/new' do
  @apartment = Apartment.create(params[:apartment])
  redirect :"/apartment/#{@apartment.id}"
end

get "/apartment/:id" do
  @apartment = Apartment.find(params[:id])
  @tenants   = @apartment.tenants
  erb :"apartment/show"
end

get "/apartment/:id/edit" do
  @apartment = Apartment.find(params[:id])
  erb :"apartment/edit"
end

put "/apartment/:id" do
  @apartment = Apartment.find(params[:id])
  @apartment.update(params[:apartment])
  redirect :"/apartment/#{@apartment.id}"
end

delete "/apartment/:id" do
  @apartment = Apartment.find(params[:id])
  @apartment.destroy
  redirect :"apartments"
end

get "/tenants" do
  @tenant = Tenant.all
  erb :"tenants/index"
end

get "/tenant/:id" do
  @tenant = Tenant.find(params[:id])
  @apartment   = @tenant.apartment
  @address = @apartment.address
  erb :"tenants/show"
end

get '/tenants/new' do
  erb :'tenants/new'
end

post '/tenants/new' do
  @tenant = Tenant.create(params[:tenant])
  redirect :"/tenants/#{@tenant.id}"
end



# puts "Hello Bob. How are you today?"
# while gets.chomp != "fine"
#   puts "Just tell me what I want to hear."
# end
# puts "Glad you decided to play ball. Your usual menu: \n
# Type 1 to overview all the apartments, type 2 to overview the tenants.\n
# Type 3 to view all the apartments with their tenants."
#
# user_input = gets.chomp
#
# case user_input
# when "1"
#  Apartment.all.each {|a| puts a.address}
# when "2"
#  Tenant.all.each {|t| puts "Name: #{t.name}, Age: #{t.age}"}
# when "3"
#   Apartment.all.each do |a|
#     puts "Apartment: #{a.address}, Tenants:"
#     a.tenants.each do |t|
#       puts "#{t.name}"
#     end
#   end
# end


puts "end of application"
