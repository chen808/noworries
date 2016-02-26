class UserMailer < ApplicationMailer
	default from: "donkeywong429@gmail.com"

	def welcome_email(email, contact_name, event, user) # pass in the session[:contact_name] from events_controller.rb (under 'create' method)
		@email = email
		@contact_name = contact_name
		@event = event
		@user = user
		#@url = # your domain name here later
		mail(to: @email, subject: "Hey, whats up")
	end 

	
end
