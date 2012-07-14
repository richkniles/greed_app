class Game < ActiveRecord::Base
  attr_accessible :player1, :player2, :state
  
  validates :player1, presence: true
  validates :player2, presence: true  
  validates :state, presence: true
  # states
  WAITING = 1
  
end
