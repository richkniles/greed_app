
class PlayersController < ApplicationController
  
  before_filter :signed_in_user, only: [:index]
  
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
  
  def index
    @players = Player.where("last_active >= ? and id <> ?", 1.minute.ago, current_player.id)
  end
  
  private
    def signed_in_user
      unless signed_in?
        redirect_to signin_path, notice: "Please sign in."
      end
    end
  
end
