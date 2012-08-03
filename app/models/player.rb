require 'pusher'


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

  include PusherKeys
  
  def send_message_to(player, message, params = {})
    
    message = "Play Greed with #{self.player_name}?" if message == "ask"
    message += " #{params[:game_id]}" if message == "join"

    message_packet = {
                        fr_id: self.id.to_s, 
                        to_id: player.id.to_s, 
                        message: message
                      }.to_json
        
    Pusher.app_id = PusherKeys::APP_ID
    Pusher.key = PusherKeys::APP_KEY
    Pusher.secret = PusherKeys::APP_SECRET

    Pusher[player.player_name].trigger('game-action', {:message => message_packet})
    
   # Message.create(from_player: self.id, to_player: player.id, message: message)
  end
  
  
    
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64 if (self.remember_token == nil)
    end
 
  
end
