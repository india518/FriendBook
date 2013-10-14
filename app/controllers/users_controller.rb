class UsersController < ApplicationController

	def friends
		if signed_in?
			@user = User.find(params[:user_id])
			deny_access_to_restricted_info unless current_user?(@user)
			@friends = @user.accepted_friends
		else
			deny_access
		end
	end

	def show
		if signed_in?
			@user = User.find(params[:id])
			deny_access_to_restricted_info unless current_user?(@user)
			#@invites = @user.invites_recieved
			#@users = query needed for users that:
			#  				 - are NOT friends
			# 				 - have NOT already invited us
			#  				 - should include those we may have already invited
		else
			deny_access
		end
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			redirect_to user_url(@user), :notice => "#{@user.name} Registered!"
		else
			render :new
		end
	end

end
