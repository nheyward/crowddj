class Venue < ActiveRecord::Base
 # Venue Model:
 #   name
 #   postcode
 #   website
 #   user_id
 
  attr_accessible :name, :postcode, :website
 
  belongs_to :user
  
  validates :name, :postcode, :presence => true
 
  #Code for image associated with Venue (Paperclip Gem) 
  has_attached_file :image, :default_url => "venue_default.jpg"
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  
  #Googlemap related bits
  acts_as_gmappable
  
  def gmaps4rails_address
    #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    self.postcode 
  end
  



end
