class Venue < ActiveRecord::Base
 # Venue Model:
 #   name
 #   postcode
 #   website
 #   user_id
  belongs_to :user
  
  validates :name, :postocde, presence => true
 
end
