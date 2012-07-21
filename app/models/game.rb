class Game < ActiveRecord::Base
  
  attr_accessible :player1, :player2, :state
  
  validates :player1, presence: true
  validates :player2, presence: true  
  validates :state, presence: true, inclusion: { in: 1..4 }
  
  has_many :player1_turns, 
              class_name: :Turn, 
              conditions: [ 'which_player=?', 1 ], 
              before_add: :set_which_player_to_1
  has_many :player2_turns, 
              class_name: :Turn, 
              conditions: [ 'which_player=?', 2 ],
              before_add: :set_which_player_to_2
  
  # states
  PLAYER1_TURN = 1
  PLAYER2_TURN = 2
  WAITING = 3
  ABANDONED = 4
  
  WinningScore = 3000
  
  def game_over?
    return true if score(1) >= WinningScore && score(2) < score(1) && 
                                  turns(1).count > turns(2).count &&
                                  turns(1).last.rolls.count == 0
      
    return true if score(2) >= WinningScore && score(1) < score(2) && 
                                  turns(1).count == turns(2).count &&
                                  turns(2).last.rolls.count == 0
    return false
  end
  
  def score(which_player)
    player_turns = turns(which_player)
    in_the_game = false
    player_turns.reduce(0) do |score,turn|
      if (in_the_game || turn.score >= 300)
        in_the_game = true
        score + turn.score
      else
        score
      end
    end
  end
  
  def roll
    case state
    when PLAYER1_TURN
      player1_turns.last.roll
    when PLAYER2_TURN
      player2_turns.last.roll
    end
  end
  
  def next_turn
    case state
    when PLAYER1_TURN
      self.state = PLAYER2_TURN
      player2_turns.create
    else
      self.state = PLAYER1_TURN
      player1_turns.create
    end
    save
  end
  
  def turns(which_player)
    case which_player
    when 1
      player1_turns
    when 2
      player2_turns
    else
      nil
    end
  end
  
  def opponent(current_player)
    if player1 == current_player.id
      Player.find(player2)
    else
      Player.find(player1)
    end
  end
  
  def my_turn? (current_player)
    which_player = current_player.id == player1 ? 1 : 2
    return which_player == state
  end
  
  def which_player_num(player)
    player.id == player1 ? 1 : 2
  end
  
  def player_score(player)
    score which_player_num(player)
  end
  
  def player_turns(player)
    turns which_player_num(player)
  end
  
  private
  
    def set_which_player_to_1(turn)
      turn.which_player = 1
    end
    def set_which_player_to_2(turn)
      turn.which_player = 2
    end
    
      
end
