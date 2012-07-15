class Game < ActiveRecord::Base
  
  attr_accessible :player1, :player2, :state
  
  validates :player1, presence: true
  validates :player2, presence: true  
  validates :state, presence: true
  
  # states
  PLAYER1_TURN = 1
  PLAYER2_TURN = 2
  WAITING = 3
  ABANDONED = 4
  
  
      
end
