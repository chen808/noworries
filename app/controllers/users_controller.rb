class UsersController < ApplicationController

	def show
		@user = User.find(params[:id]) #<----- Find the current user info by id and store info @user, send to views > users > show.html.erb
		@user_events = Event.where(user_id:session[:user_id])
	end


	def login
		@user = User.find_by_email(params[:email]) #<------ find user by email, if any, store into @user
		#session[:user_name] = @user.name

		if @user && @user.authenticate(params[:password]) #<---- does user password match up?
			session[:user_id] = @user.id #<----- store user id to session (can be used later on)
			redirect_to '/users/%d' % session[:user_id] 
		else
			flash[:errors] = ["Invalid combination"] #<--- if validation fails, send error warning
			redirect_to :back
		end
	end



end
