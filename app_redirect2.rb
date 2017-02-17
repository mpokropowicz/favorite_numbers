require 'sinatra'
require 'sinatra/reloader' if development?

get "/" do 

	@title = "What is your name?"

	erb :get_name
end

post "/name" do

	backend_name = params[:name]
	redirect "location?name=" + backend_name
end

get "/location" do

	@title = "What is your location?"
	@user_name = params[:name]

	erb :get_location_redir
end

post "/location" do

	user = params[:user]

	redirect "numbers?user=" + user.to_s
end

get "/numbers" do

	user = eval(params[:user])
	@title = "Enter your three favorite numbers."
	@user_name = user["name"]
	@user_location = user["location"]

	erb :get_numbers_redir
end

post "/numbers" do

	user = params[:user]

	redirect "age?user=" + user.to_s
end

get "/age" do

	user = eval(params[:user])
	@title = "What is your age?"
	@user_name = user["name"]
	@user_location = user["location"]
	@user_numbers = user["numbers"]

	erb :get_age_redir
end

post "/age" do 

	user = params[:user]

	redirect "results?user=" + user.to_s
end

get "/results" do
	
	user = eval(params[:user])
	@user_name = user["name"]
	@user_location = user["location"]
	@user_numbers = user["numbers"]
	@user_age = user["age"]

	sum = 0
	@user_numbers.split(",").each_with_index{|n|sum += n.to_i}
	g_or_l = sum.to_i > @user_age.to_i ? "greater" : "less"

	@title = "Hey #{@user_name}, your age is #{@user_age}, your location is #{@user_location},your three favorite numbers are #{@user_numbers} and their sum is #{sum}, and it is #{g_or_l} than your age."
end