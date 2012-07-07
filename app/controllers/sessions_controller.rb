
class SessionsController < ApplicationController
  
  
  def new
    render 'new'
  end
  
  def create
    player = Player.find_by_email(params[:email])
    if player && player.authenticate(params[:password])
      sign_in player
      redirect_to player
    else
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
  
end
