class User < ActiveRecord::Base
  has_many :venues
  
  validates :name, :email, :presence => true

  
  
end
