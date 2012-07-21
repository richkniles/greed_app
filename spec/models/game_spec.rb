require 'spec_helper'

describe Game do
  
  let(:game) { Game.new(player1: 1, player2: 1, state: Game::WAITING) }
  subject { game }
  
  it { should respond_to :player1 }
  it { should respond_to :player2 }
  it { should respond_to :state }
  it { should respond_to :player1_turns }
  it { should respond_to :player2_turns }
  it { should respond_to :score }
  it { should respond_to :roll }
  it { should respond_to :next_turn }
  it { should be_valid }
  
  describe "with missing player1" do
    before { game.player1 = nil }
    it { should_not be_valid }
  end
  
  describe "with missing player2" do
    before { game.player2 = nil }
    it { should_not be_valid }
  end
  
  describe "with missing state" do
    before { game.state = nil }
    it { should_not be_valid }
  end
  
  describe "with invalid state" do
    before { game.state = 5 }
    it { should_not be_valid }
  end
  
  describe "with valid state" do
    before { game.state = 4 }
    it { should be_valid }
  end
  
  describe "next_turn" do
    before { game.save }
    it "should change state" do
      expect { game.next_turn }.to change(game, :state).to Game::PLAYER1_TURN
      expect { game.next_turn }.to change(game, :state).to Game::PLAYER2_TURN
      expect { game.next_turn }.to change(game, :state).to Game::PLAYER1_TURN
    end
    
    it "should create a turn" do
      expect { game.next_turn }.to change(game.player1_turns, :count).by 1
      expect { game.next_turn }.to change(game.player2_turns, :count).by 1
    end
  end
  
  describe "rolling" do
    before { game.save }
    
    it "should do nothing if state is waiting" do
      expect { game.roll }.not_to change(game.player1_turns, :count)
    end
    
    it "should add a roll to appropriate player's turn" do
      game.next_turn
      expect { game.roll }.to change(game.player1_turns.last.rolls, :count).by 1
      game.next_turn
      expect { game.roll }.to change(game.player2_turns.last.rolls, :count).by 1
    end
  end
  
=begin
can't sign in in a model test, so have to defer this test   
  describe "my_turn?" do
    before do
      me = FactoryGirl.create(:player)
      sign_in_without_capybara me
      opponent = FactoryGirl.create(:player)
      new_game = Game.create(player1: me.id, player2: opponent.id, state: Game::WAITING)
    end
    
    it "should be false while game is waiting" do
      my_turn?.should be_false
    end
    
    it "should turn true after next_turn" do
      new_game.next_turn
      my_turn?.should be_true
    end
    
    it "should be false every other turn" do
      new_game.next_turn
      new_game.next_turn
      my_turn?.should be_false
    end
    
  end
=end

  describe "score" do
    
    it "should initially be 0" do
      game.score(1).should == 0
      game.score(2).should == 0
    end
    it "should change when roll" do
      game.save
      game.next_turn
      game.roll
      if game.player1_turns.last.rolls.last.score >= 300
        game.score(1).should be > 0 
      end
    end
  end
  
  describe "the game of Greed" do
    before { game.save }
    this_player = 2
    
    it "should play greed" do
      begin
      
        game.next_turn
        this_player = 3 - this_player
      
        turn_score = 0
        begin 
          game.roll
          turn_score = game.turns(this_player).last.score
          wants_to_continue = (rand(100) >= (this_player == 1 ? 50 : 40) || game.score(this_player) == 0)
        end while turn_score > 0 && wants_to_continue
      
        other_player = 3 - this_player
        other_player_needs_to_go = (game.score(this_player) > 3000 && game.score(other_player) <= 3000)
        puts "player 1: #{game.score(1)}  player 2: #{game.score(2)}"
      end while game.score(1) < 3000 && game.score(2) < 3000 || other_player_needs_to_go

    end
  end
  
end
