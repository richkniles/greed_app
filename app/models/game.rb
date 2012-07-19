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
  
  def score
    0
  end
  
  def roll
    
  end
  
  def pass
    
  end
  
  private
  
    def set_which_player_to_1(turn)
      turn.which_player = 1
    end
    def set_which_player_to_2(turn)
      turn.which_player = 2
    end
    
      
end
