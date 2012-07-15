module SessionsHelper
  
  def sign_in(player)
    cookies.permanent[:remember_token] = player.remember_token
    self.current_player = player
  end
  
  def sign_out
    #forget current_game
    if playing?
      current_player.send_message_to(current_opponent, "#{current_player.player_name} just logged off.")
      current_game.state = Game::ABANDONED
      current_game.save
      self.current_game = nil
    end
    
    # set inactive
    current_player.last_active = nil
    current_player.save validate: false
    
    #forget current_player
    self.current_player = nil
    cookies.delete(:remember_token)
    
 end

  def signed_in?
    !current_player.nil?
  end
  
  def must_be_signed_in
    if !signed_in?
      flash[:error] = "Please sign in";
      redirect_to root_path 
    end
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
  
  def current_game=(game)
    logger.debug "3333>>>>    setting current game to #{game.inspect}"
    session[:game] = game
  end
  
  def current_game
    session[:game]
  end
  
  def playing?
    session[:game] if signed_in?
  end
  
  def current_opponent
    game = current_game
    return nil unless playing? && signed_in?
    
    pid = current_player.id
    oid = game.player1 == pid ? game.player2 : game.player1
    Player.find(oid)
  end

end
