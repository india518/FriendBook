class FriendshipsController < ApplicationController

	def create
		#we are creating two friendships
		#first, the friendship where the user invites the friend:
		@request = current_user.friendships.new
		@request.friend_id = params[:friendship][:friend_id]
		@request.status = false

		if @request.save
			#next, the friendship where the user is invited by the friend
			@recieve = Friendship.new
			@recieve.user_id = @request.friend_id
			@recieve.friend_id = @request.user_id
			if @recieve.save
				redirect_to user_url(current_user)
			else
				@request.destroy
				redirect_to user_url(current_user),
					:flash => { :alert => "Unable to send invite (invitee unable to recieve invitation)" }
			end
		else
			redirect_to user_url(current_user),
					:flash => { :alert => "Unable to extend invitation to that user" }
		end
	end

	def update
		#invitation has been accepted!
		#now we set both 'friendships' to true
		@friendship = Friendship.find_by_user_id(params[:id])
		@reciprocal = Friendship.find_by_friend_id(params[:id])
		@friendship.status = true
		@reciprocal.status = true
		if @friendship.save && @reciprocal.save
			redirect_to user_url(current_user), 
				:flash => { :notice => "Friendship accepted!" }
		else
			@friendship.destroy
			@reciprocal.destroy
			redirect_to user_url(current_user),
				:flash => { :alert => "Problem accepting Friendship: Invite denied."}
		end
	end

	def destroy
		user = User.find(params[:id])
		@friendship = Friendship.find_by_user_id(params[:id])
		@reciprocal = Friendship.find_by_friend_id(params[:id])
		@friendship.destroy
		@reciprocal.destroy
		redirect_to user_url(current_user),
			:flash => { :notice => "#{user.first_name}'s invitation ignored"}
	end

end
