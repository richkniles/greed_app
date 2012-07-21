
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
      @game.next_turn
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
    to_do = params[:move]
    current_game = Game.find(params[:id])
    if to_do == "roll"
      logger.debug("doing roll on game #{current_game.id}")
      current_game.roll
      logger.debug("did roll")
    else
      current_game.next_turn
    end
    opponent = current_game.opponent(current_player)
    current_player.send_message_to opponent, "Update"
    redirect_to "/games/#{current_game.id}"
  end

  def index
  end

  def edit
  end

  def show
    @game = Game.find(params[:id])
    player1 = Player.find(@game.player1)
    player2 = Player.find(@game.player2)
    @opponent = player1.id == current_player.id ? player2 : player1
    @turn_score = 0
    turns = @game.turns(@game.state)
    @rolls = turns.last.rolls
    if (!turns.nil? && turns.any? && turns.last.rolls.any?)
      @turn_score = turns.last.score
      @roll_score = turns.last.rolls.last.score
      @roll = @rolls.last
    end
    if @game.game_over?
      if @game.player_score(current_player) > @game.player_score(@opponent)
        @winner = current_player
      else
        @winner = @opponent
      end
    end
  end

  def destroy
  end
end
