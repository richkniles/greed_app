module SessionsHelper
  
  def sign_in(player)
    cookies.permanent[:remember_token] = player.remember_token
    self.current_player = player
  end
  
  def sign_out
    current_player.last_active = nil
    current_player.save validate: false
    self.current_player = nil
    cookies.delete(:remember_token)
  end

  def signed_in?
    !current_player.nil?
  end

  def current_player=(player)
    @current_player = player
  end

  def current_player
   @current_player ||= Player.find_by_remember_token(cookies[:remember_token])
  end
  
  def tweek_current_player
    if (signed_in?)
      current_player.last_active = Time.now
      current_player.save validate: false
    end
  end

end
