
class PlayersController < ApplicationController
  
  def show
    @player = Player.find(params[:id])
  end
  
  def new
    @player = Player.new
  end
  
  def create
    @player = Player.new(params[:player])
    if @player.save
      sign_in @player
      flash[:success] = "Welcome to Greed!"
      redirect_to @player
    else
      render 'new'
    end
  end
end
