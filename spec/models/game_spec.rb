require 'spec_helper'

describe Game do
  
  let(:game) { Game.new(player1: 1, player2: 1, state: Game::WAITING) }
  
  subject { game }
  
  it { should respond_to :player1 }
  it { should respond_to :player2 }
  it { should respond_to :state }
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
  
end
