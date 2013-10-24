class UsersController < ApplicationController

	def friends
		if signed_in?
			deny_restricted_info unless current_user? User.find(params[:user_id])
			@friends = current_user.accepted_friends
		else
			deny_access
		end
	end

	def show
		if signed_in?
			deny_restricted_info unless current_user? User.find(params[:id])
			# fetching here to cut down database queries on the show template
			@users = User.where("id != ?", current_user.id)
			@invites_recieved = current_user.invites_recieved
			@invites_sent = current_user.invites_sent
			@friends = current_user.accepted_friends
			#and this last is for the forms to 'accept' a friendship
			@friendship = Friendship.new
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
			redirect_to user_url(@user)
		else
			render :new
		end
	end

end
