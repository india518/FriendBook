class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => "User"
  attr_accessible :status

  #before_save { self.status = :false } 
end
