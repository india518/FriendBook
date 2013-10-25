class FriendshipsController < ApplicationController

	def create
		#first, check to see if we have recieved an invite by this user already
		@recieved = Friendship.where(:user_id => params[:friendship][:friend_id],
																 :friend_id => current_user).first
		#NOTE: Using the *.where clause (as above) returns a collection, even if there is only one result! Therefore, we use *.first to actually get inside the collection to the Friendship object we want.

		if @recieved.nil?
			#We haven't recieved one, so send out an invitation!
			@invite = current_user.friendships.new(:status => 0)
			@invite.friend_id = params[:friendship][:friend_id]
			if @invite.save
				redirect_to user_url(current_user)
			else
				redirect_to user_url(current_user),
					:alert => "Unable to extend invitation to that user"
			end
		else	#update existing friendship
			@recieved.status = 1
			redirect_to user_url(current_user),
				:notice => "Friendship accepted!" if @recieved.save
		end
	end

	def update
		#We accept! Find this 'friendship' and set the status to 1
		#Using the *.where clause returns a collection, evne if there is only one
		#result, so we have to use *.first to get to the object itself!
		@friendship =
			Friendship.where(:user_id => params[:id],
											 :friend_id => current_user).first
		@friendship.status = 1

		if @friendship.save
			redirect_to user_url(current_user), :notice => "Friendship accepted!"
		else
			@friendship.destroy
			redirect_to user_url(current_user),
				:alert => "Problem accepting Friendship: Invite denied."
		end
	end

	def destroy
		user = User.find(params[:id])	#need for flash message
		@friendship = Friendship.where(:user_id => params[:id],
																	 :friend_id => current_user).first.destroy
		redirect_to user_url(current_user),
			:notice => "#{user.first_name}'s invitation ignored"
	end

end
