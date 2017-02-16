require 'sinatra'
require 'sinatra/reloader' if development?

enable :sessions

get "/" do

	@title = "What is your name?"

	erb :get_name
end

post "/name" do

	@title = "What is your location?"
	session[:user_name] = params[:name]

	erb :get_location
end

post "/location" do

	@title = "What are your three favorite numbers?(Seperate each by a comma)?"
	session[:user_location] = params[:location]

	erb :get_numbers
end

post "/numbers" do

	@title = "What is your age?"
	session[:user_numbers] = params[:numbers]

	erb :get_age
end

post "/age" do

	session[:user_age] = params[:age]

	sum = 0
	session[:user_numbers].split(",").each_with_index{|n|sum += n.to_i}
	g_or_l = sum.to_i > @user_age.to_i ? "greater" : "less"

	@title = "Hey #{session[:user_name]}, your age is #{session[:user_age]}, your location is #{session[:user_location]},your three favorite numbers are #{session[:user_numbers]} and their sum is #{sum}, and it is #{g_or_l} than your age."
end