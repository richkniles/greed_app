require 'lib/die.rb'
require 'lib/dice.rb'

class Roll < ActiveRecord::Base
  attr_accessible :turn_id
  
  belongs_to :turn
  
  def init(start = [0,0,0,0,0,0])
    start = [0,0,0,0,0,0] if start.count == 0
    self.dice_string = start.join ' '
    @scoring_triples = @scoring_singles = @dice = nil
    @score = -1
  end

  def dice
    @dice ||= Dice.new(dice_string ? dice_string.split.map { |digit| digit.to_i } : [])
  end
  
  def score
    @score = dice.score
    @score
  end
    
  def roll
    init if dice_string.nil?
    dice_array = []
    dice.count.times do
      dice_array << (rand(6) + 1)
    end
    init dice_array
  end
  
  def progress_to_next_roll
    next_dice = dice.clone
    next_dice.subtract(dice.scoring_dice)
    next_roll = Roll.create(turn_id: self.turn_id) 
    if next_dice.count > 0
      next_roll.init (next_dice.values)
    else
      next_roll.init []
    end
    next_roll
  end
    
  def scoring_dice
    dice.scoring_dice.map { |d| d.value }
  end
  
  def non_scoring_dice
    dice.non_scoring_dice.map { |d| d.value }
  end
  
  def scoring_indices
    dice.scoring_dice.map { |d| d.index }
  end
end
