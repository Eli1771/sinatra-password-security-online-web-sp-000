Skip to content
 
Search or jump to…

Pull requests
Issues
Marketplace
Explore
 
@Eli1771 
0
0 65 Eli1771/sinatra-password-security-online-web-sp-000
forked from learn-co-students/sinatra-password-security-online-web-sp-000
 Code  Pull requests 0  Projects 0  Security  Insights  Settings
sinatra-password-security-online-web-sp-000/app/controllers/application_controller.rb
 maxwell aligned solution and master commit trees, updated migration
e252c48 on Mar 7
@ipc103 @maxwellbenton
70 lines (57 sloc)  1 KB
    
require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

	configure do
		set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
	end

	get "/" do
		erb :index
	end

	get "/signup" do
		erb :signup
	end

	post "/signup" do
		user = User.new(:username => params[:username], :password => params[:password])
		if user.save
			redirect "/login"
		else
			redirect "/failure"
		end
	end

	get "/login" do
		erb :login
	end

	post "/login" do
		user = User.find_by(:username => params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect "/success"
		else
			redirect "failure"
		end
	end

	get "/success" do
		if logged_in?
			erb :success
		else
			redirect "/login"
		end
	end

	get "/failure" do
		erb :failure
	end

	get "/logout" do
		session.clear
		redirect "/"
	end

	helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end

end
© 2019 GitHub, Inc.
Terms
Privacy
Security
Status
Help
Contact GitHub
Pricing
API
Training
Blog
About
