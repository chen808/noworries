class SessionsController < ApplicationController

	def index
	end

	# Creates new user
	def create
		User.create(name:params[:name],email:params[:email],password:params[:password])

		user = User.find_by_email(params[:email])

		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to '/users/%d' % session[:user_id]
		else
			flash[:errors] = ["Invalid combination"]
			redirect_to :back
		end
	end

	# Log out session
	def destroy
		session.clear #<---- this turns current session to inactive
		redirect_to root_path
	end

end
