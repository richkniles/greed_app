class Player < ActiveRecord::Base
  attr_accessible :player_name, :email, :password, :password_confirmation
  has_secure_password
  
  validates :player_name, presence:   true, 
                          uniqueness: true, 
                          length:     { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,       presence:   true, 
                          format:     { with: VALID_EMAIL_REGEX },
                          uniqueness: { case_sensitive: false }
  validates :password,    presence:   true, 
                          length: { minimum: 6 }
  validates :password_confirmation, 
                          presence: true
                          
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64 if (self.remember_token == nil)
    end
 
  
end