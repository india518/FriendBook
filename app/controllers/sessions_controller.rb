class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_email(params[:session][:email])
		if user == false || user.nil?
			redirect_to login_url,
			:flash => { :alert => 'No user exists with that email' }

		user.try(:authenticate, params[:session][:password])
		if user == false || user.nil?
			redirect_to login_url,
			:flash => { :alert => 'Incorrect password.' }
		else
			sign_in user
			redirect_to user_url(user)
		end
	end

	def destroy
		sign_out
		redirect_to login_url
	end
	
end
