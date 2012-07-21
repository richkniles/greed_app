require 'spec_helper'

describe Turn do
  
  let!(:game) { Game.create(player1: 1, player2: 1, state: Game::PLAYER1_TURN) }

  describe "player1's turns" do
    
    let!(:turn) { game.player1_turns.create }
  
    subject { turn }
  
    it { should respond_to :game }
    it { should respond_to :which_player }
    it { should respond_to :rolls }
    it { should respond_to :roll  }
    it { should respond_to :score }
  
    it "should be player1's" do
      turn.which_player.should == 1
    end
  
    it { should == game.player1_turns.last }
  
    it "should not show up in player2_turns" do
      game.player2_turns.first.should be_nil
    end
  
    describe "rolls" do
      it "should have no rolls" do
        turn.rolls.first.should be_nil
      end
    
      it "should have another roll after rolling" do
        expect { turn.roll }.to change(turn.rolls, :count).by 1
      end
    
      it "should initially have score 0" do
        turn.score.should == 0
      end
    
      it "should change the roll score after rolling" do
        turn.roll
        turn.score.should == turn.rolls.last.score
        turn.roll
        if (turn.rolls.last.score > 0)
          turn.score.should == turn.rolls.first.score + turn.rolls.last.score
        else
          turn.score.should == 0
        end
      end
      
    end
  end
  
  describe "player2's turns" do
    
    let(:turn) { game.player2_turns.create }
    
    subject { turn }
  
    it "should be player2's" do
      turn.which_player.should == 2
    end
  
    it { should == game.player2_turns.last }
  
    it "should not show up in player1_turns" do
      game.player1_turns.first.should be_nil
    end
  end
  
  describe "scoring" do
  
    let!(:turn) { game.player1_turns.create }
    
    # it "should have score 0 after rolling 0" do
    #   begin 
    #     turn.roll
    #     last = turn.rolls.last
    #   end until (last.score == 0)
    # 
    #   turn.score.should == 0
    # end
  
    
  end
  
end
