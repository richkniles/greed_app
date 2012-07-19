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
    dice_array = dice
    dice_array = dice.each_with_index.map do |die, i| 
      (scoring_dice.include? i) ? die : rand(6)+1 
    end
    self.dice_string = dice_array.join ' '
    @scoring_triples = @scoring_singles = @dice = nil
    @score = -1
  end
  
  def progress_to_next_roll
    next_dice = dice.clone
    next_dice.subtract(dice.scoring_dice)
    next_roll = Roll.new 
    next_roll.init (next_dice.map { |d| d.value })
    next_roll
  end
    
  def scoring_dice
    dice.scoring_dice.map { |d| d.value }
  end
  
  def scoring_indices
    dice.scoring_dice.map { |d| d.index }
  end
end
