require 'set'

class Dice < Set
  
  def initialize(x = [])
    super()
    x.each_with_index { |v, i| self << Die.new(i,v) }
  end
  
  def same_sets
    classify { |d| d.value }.values.to_set
  end
  
  def values
    map { |d| d.value }
  end
  
  def score
    same_sets.reduce(0) { |memo,s| memo += s.score_as_same_set }
  end
  
  def scoring_dice
    scoring_sets = same_sets.select { |s| is_scoring(s) }
    scoring_sets.reduce(Dice.new) { |memo,s| memo.merge(s) }
  end
  
  def non_scoring_dice
    self.clone.subtract scoring_dice
  end
  
  def score_as_same_set
    v = first.value
    n = count
    case count
    when 1,2
      case v
        when 1 
          100*n
        when 5 then 50*n
        else 0
      end
    when 3..6
      mult = 1
      (n-3).times { mult *= 2 }
      case v
        when 1 then 1000*mult
        when 2..6 then v*100*mult
        else 0
      end
    else 0
    end 
  end
  
  #private 
    def is_scoring(s)
      v = s.first.value
      case s.count
      when 1,2
        case v
        when 1,5 then true
        else false
        end
      when 3..6
        true
      end
    end
  
end