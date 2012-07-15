
class GamesController < ApplicationController
  
  before_filter :must_be_signed_in
  
  def new 
    @player1 = current_player
    @player2 = Player.find params[:opponent] if (params[:opponent])
    @game = Game.new(player1: @player1.id)
    @player1.send_message_to(@player2, "ask")
  end
  
  def create
    player2_id = params[:game] ? params[:game][:player2] : params[:player2]
    @game = Game.new(player1: current_player.id, player2: player2_id, state: Game::WAITING)
    @opponent_name = Player.find(@game.player2).player_name
    if (@game.save)
      render json: @game
      #   this didn't work:  why???
      # respond_to  do |format|
      #   format.html { redirect_to @game }
      #   format.js { render json: @game.id }
      # end
    #else
    #   do something to recover
    end
  end
  
  def update
  end

  def index
  end

  def edit
  end

  def show
    @game = Game.find(params[:id])
    if (@game.state == Game::ABANDONED)
      self.current_game = nil
    else
      self.current_game = @game
    end
    @player1 = Player.find(@game.player1)
    @player2 = Player.find(@game.player2)
    @opponent = @player1.id == current_player.id ? @player2.player_name : @player1.player_name
  end

  def destroy
  end
end
