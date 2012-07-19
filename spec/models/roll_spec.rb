require 'spec_helper'

describe Roll do
  
  let(:game) { Game.new() }
  let(:turn) { Turn.new(which_player: 1, game_id: game.id)}
  let(:r) { Roll.new(turn_id: turn.id) }
  
  subject { r }
  
  it { should respond_to(:turn)  }
  it { should respond_to(:init)  }
  it { should respond_to(:dice)  }
  it { should respond_to(:roll)  }
  it { should respond_to(:score) }
  it { should respond_to(:scoring_dice) }
  it { should respond_to(:progress_to_next_roll)}
  
  describe "dice" do
    
    it "should initially be empty" do
      r.dice.count.should == 0;
    end
    
    it "should init to any number of dice" do
      r.init [1,2,3]   
      r.dice.count.should == 3
    end 
    
    it "should init to 6 dice by default" do
      r.init
      r.dice.count.should == 6
      r.init []
      r.dice.count.should == 6
    end
    
  end
  
  describe "rolling" do
      
    it "should have 6 numbers 1..6 after rolling" do
      r.init [0,0,0,0,0,0]
      r.roll
      r.dice.length.should == 6
    end
    
    it "should produce numbers between 1 and 6" do
      r.init [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
      r.roll
      r.dice.each do |die|
        (1..6).should === die.value
      end
    end
    
    it "should not change the number of dice" do
      r.init [1,2,3]
      r.roll
      r.dice.count.should == 3
    end
    
    it "should only rarely (1/46656 rolls) be the same roll twice in a row" do
      r.init [0,0,0,0,0,0]
      r.roll
      first_result = r.dice.clone
      r.roll
      second_result = r.dice
      first_result.should_not == second_result
    end

  end
  
  describe "progressing to next roll" do
    
    it "should not effect current roll" do
      r.init [1,2,3,4,5,6]
      prev_dice = r.dice.clone
      r.progress_to_next_roll
      prev_dice.should == r.dice
    end
    
    it "should produce another roll with non-scoring dice" do
      r.init [1,2,3,4,5,6]
      r_next = r.progress_to_next_roll
      r_next.dice.values.should == [2,3,4,6]
    end
    
    it "should always produce a new roll with zero score" do
      r.init
      10.times do
        r.roll
        r_next = r.progress_to_next_roll
        r_next.score.should == 0
      end
    end
    
    it "should produce a roll with 6 dice when all are scoring" do
      r.init [1,1,5]
      r_next = r.progress_to_next_roll
      r_next.dice.count.should == 6
    end
    
    it "should produce a roll with all the non-scoring dice" do
      r.init [1,2,3,4,5,6]
      r_next = r.progress_to_next_roll
      r_next.dice.values.should == [2,3,4,6]
      
      r.init [1,2,1,3,1,6]
      r_next = r.progress_to_next_roll
      r_next.dice.values.should == [2,3,6]
      
      r.init [1,2,1,1,1,6]
      r_next = r.progress_to_next_roll
      r_next.dice.values.should == [2,6]
      
      r.init [2,2,3,4,5,6]
      r_next = r.progress_to_next_roll
      r_next.dice.values.should == [2,2,3,4,6]     
    end
    
  end
  
  describe "scoring dice" do
    it "should always be complementary to the next roll" do
      10.times do
        r.init #init with 6 dice
        r.roll
        r_next = r.progress_to_next_roll
        scoring_dice = r.scoring_dice
        next_roll_dice = r_next.dice.values
        (scoring_dice.concat next_roll_dice).sort.should == r.dice.values.sort
      end
    end
  end
  
end
