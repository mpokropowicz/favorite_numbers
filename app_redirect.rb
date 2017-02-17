require "sinatra"
require "sinatra/reloader" if development?

use Rack::Session::Cookie, :key => "rack.session"

get "/" do

	@title = "What is your name?"

	erb :get_name
end

post "/name" do 

	session[:user_name] = params[:name]
	redirect "/location"
end

get "/location" do

	@title = "What is your location?"
	erb :get_location
end

post "/location" do

	session[:user_location] = params[:location]
	redirect "/numbers"
end

get "/numbers" do

	@title = "What are your three favorite numbers?(Please enter numbers separated by a comma)"
	erb :get_numbers
end

post "/numbers" do

	session[:user_numbers] = params[:numbers]
	redirect "/age"
end

get "/age" do

	@title = "What is your age?"
	erb :get_age
end

post "/age" do

	session[:user_age] = params[:age]
	redirect "/final"
end

get "/final" do

	sum = 0
	session[:user_numbers].split(",").each_with_index{|n|sum += n.to_i}
	g_or_l = sum.to_i > @user_age.to_i ? "greater" : "less"

	@title = "Hey #{session[:user_name]}, your age is #{session[:user_age]}, your location is #{session[:user_location]},your three favorite numbers are #{session[:user_numbers]} and their sum is #{sum}, and it is #{g_or_l} than your age."
end