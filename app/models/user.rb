class User < ActiveRecord::Base
	CRAZY_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

  attr_accessible :email, :first_name, :last_name, :password,
  								:password_confirmation
  has_many :friendships
  has_many :friends, :through => :friendships, :class_name => "User", :foreign_key => "friend_id"

  validates :first_name,	:last_name,	:presence		=> true,
																			:length			=> { :within => 1..50 }
	validates :email,				:presence	=> true,
													:format 	=> { :with 		=> CRAZY_EMAIL_REGEX,
																			 :message	=> "The email provided is not a valid email address."},
													:uniqueness	=> { :case_sensitive => false }
	validates :password,								:presence		=> true,
																			:length			=> { :within => 6..40 }

	before_save { self.email = email.downcase } 
	has_secure_password

	def name
		"#{self.first_name} #{self.last_name}"
	end

	def invites_sent
		#query to get list of people you have invited
	end

	def invites_recieved
		#query to get list of people you have recieved invites from
	end

end
