module SessionsHelper

	def sign_in(user)
    session[:user_id] = user.id
    self.current_user = user
  end
  
  # setter method
  def current_user=(user)
    @current_user = user
  end

  # getter method
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    session[:user_id] = nil
    self.current_user = nil
  end

  def current_user?(user)
    user == current_user 
  end

  def deny_access
    redirect_to login_path, :alert => "Please sign in to access that page."
  end

  def deny_restricted_info
    #No matter what the bad user is doing, redirect to their dashboard:
    redirect_to user_url(current_user),
                :alert => "You do not have the authority to access that page!"
  end
end
