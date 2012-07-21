class Turn < ActiveRecord::Base
  attr_accessible :which_player, :game_id
  
  has_many :rolls
  belongs_to :game
  
  def score
    return 0 if !rolls.any? || rolls.last.score == 0   
    sc = rolls.reduce(0) { |sc, r| sc += r.score } 
  end
  
  def roll
    if rolls.any?
      r = rolls.last.progress_to_next_roll
    else
      r = self.rolls.create
      r.init
    end
    r.roll
    r.save
    reload 
  end
  
end

