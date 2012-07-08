
class GamesController < ApplicationController
  
  def new
    @player1 = current_player
    @player2 = params[:opponent]
  end
  
  def create
    @game = Game.new(player1: current_player, player2: params[:opponent])
    @opponent_name = Player.find(@game.player2).player_name
    if (@game.save)
      render 'show'
    else
      #do something to recover
    end
  end
  
  def update
  end

  def index
  end

  def edit
  end

  def show
  end

  def destroy
  end
end
