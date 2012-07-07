module SessionsHelper
  
  def sign_in(player)
    cookies.permanent[:remember_token] = player.remember_token
    self.current_player = player
  end
  
  def sign_out
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

end
