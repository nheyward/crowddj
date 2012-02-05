class Venue < ActiveRecord::Base
 # Venue Model:
 #   name
 #   postcode
 #   website
 #   user_id
 
  attr_accessible :name, :postcode, :town, :website, :image
 
  belongs_to :user
  
  validates :name, :presence => true
  validates :postcode, :length => { :in => 3..9 }, :allow_blank => true
  validates :town, :length => { :in => 3..25 }, :allow_blank => true
  
  #Code for image associated with Venue (Paperclip Gem) 
  has_attached_file :image, :default_url => "venue_default.jpg"
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  
  #Googlemap related bits
  acts_as_gmappable :validation => false, :check_process => false
  geocoded_by :postcode
  after_validation :geocode 
  
  def gmaps4rails_address
    #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.town}, #{self.postcode}"
  end
  
  def self.search(namesearch, locationsearch, page)
    if locationsearch
      page(page).near(locationsearch, 10)
    elsif namesearch
      paginate(:per_page => 25, :page => page,
               :order => "name", :conditions => ['name LIKE ?', "%#{namesearch}%"])
    else
      paginate(:per_page => 25, :page => page, :order => "name")
    end
  end



end
