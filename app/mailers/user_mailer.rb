class UserMailer < ApplicationMailer
	default from: "donkeywong429@gmail.com"

	def welcome_email(email, contact_name, event, user, longitude, latitude) # pass in the session[:contact_name] from events_controller.rb (under 'create' method)
		# the following instance variable makes it available to app > views > user_mailer > welcome_email.html
		@email = email
		@contact_name = contact_name
		@event = event
		@user = user
		@longitude = longitude
		@latitude = latitude
		#@url = # your domain name here later
		mail(to: @email, subject: "This is a message from No Worries") # find the body of email app > views > user_mailer > welcome_email.html
	end 

	
end
