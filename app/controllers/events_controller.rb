class EventsController < ApplicationController

	def create
		# getting the expected time done, assign to 'completion' column
		if params[:completion] == "5s"
			comp_num = 5 #this is to test only
			in5sec # call on this method to start the countdown

		elsif params[:completion] == "1hr"
			comp_num = 1
			in1hr

		elsif params[:completion] == "2hr"
			comp_num = 2

		elsif params[:completion] == "3hr"
			comp_num = 3

		else params[:completion] == "4hr"
			comp_num = 4

		end
			
		Event.create(user:User.find(session[:user_id]), event:params[:event], comment:params[:comments], completion:comp_num, contact:params[:contact_name], ph:params[:contact_ph], email:params[:contact_email], address:params[:address])
		session[:contact_name] = params[:contact_name]
		session[:event] = params[:event]

		current_user_event = Event.last # finds the latest created event


		@event = params[:event]
		@contact_name = params[:contact_name]
		@contact_email = params[:contact_email]



		@longitude = current_user_event.longitude
		@latitude = current_user_event.latitude

		# the following was successful in passing to html/email
		# @longitude = -157.8583333
		# @latitude = 21.3069444
	end



	def destroy
		@event_to_destroy = Event.find(params[:id])
		@event_to_destroy.destroy # destroy the event entirely

		event_timer = @event_to_destroy.completion # get the completion number
		
		$scheduler.jobs(:tag => params[:task]).each do |x|
			x.unschedule
		end

		redirect_to :back

	end


	def in5sec
		job30 = $scheduler.in('5s' , :tag => params[:event]) do
			
			message = "Hello #{session[:contact_name]}, We at NoWorries noticed #{current_user.name} hasn't checked in from their #{session[:event]} event, is everything okay?"
			number = params[:contact_ph] # currently only taking my phone number as this app is on twilio trial account
			account_sid = ENV["twilio_sid_key"] # key can be found at config > application.yml
			auth_token = ENV["twilio_auth_token"] # key can be found at config > application.yml

			@client = Twilio::REST::Client.new account_sid, auth_token

			@message = @client.account.messages.create({ :to => "+1"+"#{number}",
														:from => "+18316090982",
														:body => "#{message}" })

			# will be passing in conatct_email, contact_name, event, and current user to UserMailer
			# can be found at controller > mailers > application_mailer.rb
			UserMailer.welcome_email(@contact_email, @contact_name, @event, current_user.name, @longitude, @latitude).deliver_now
		end
		
		redirect_to :back 
	end


	# copy above code and change to 1 hr here
	# copy above code and change to 2 hr here
	# copy above code and change to 3 hr here
	# copy above code and change to 4 hr here

end
