class User < ActiveRecord::Base
  
  has_many :venues, :dependent => :destroy
  
  #Set which attributes can be set by mass assignment for securty..
  attr_accessible :name, :email, :password, :password_confirmation
  #Set attributes that arent part of the DB model - Password and confirmation are not in the database, so need to add these:
  attr_accessor :password
  validates_confirmation_of :password #Authentication as per railscast episode 250]
  
  before_save :encrypt_password
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => true
  validates :name, :password, :presence => true
  
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == password + user.password_salt
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      #Needs a stronger e=implementation eventually!
      self.password_salt = "Bosh"
      self.password_hash = password + password_salt
    end
  end
end
