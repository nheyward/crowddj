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
end
