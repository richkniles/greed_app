class Turn < ActiveRecord::Base
  attr_accessible :which_player, :game_id
  
  has_many :rolls
  belongs_to :game
  
  def score
    return 0 if !rolls.any? || rolls.last.score == 0   
    sc = rolls.reduce(0) { |sc, r| sc += r.score } 
  end
  
  def roll
    r = rolls.create
    r.roll
  end
  
end

