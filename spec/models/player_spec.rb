require 'spec_helper'

describe Player do
  let(:player) do 
    Player.new(player_name: "JJ", email: "jj@jj.com",
                  password: "foobar",
                  password_confirmation: "foobar")
  end
  subject { player }
  
  it { should respond_to(:player_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  
  it { should be_valid }
  
  describe "when player_name is missing" do
    before { player.player_name = " " }
  
    it { should_not be_valid }
  end
  
  describe "when email is missing" do
    before { player.email = " " }
  
    it { should_not be_valid }
  end
  
  describe "player name must be unique" do
    before { FactoryGirl.create(:player, player_name: "JJ") }
    
    it { should_not be_valid }
  end
  
  describe "player email must be unique" do
    before { FactoryGirl.create(:player, email: "jj@jj.com") }
    
    it { should_not be_valid }
  end
  
  describe "player email must be case insensitive" do
    before { FactoryGirl.create(:player, email: "JJ@jj.com") }
    
    it { should_not be_valid }
  end
  
  describe "player name must be fewer than 50 characters" do
    before { player.player_name = "a"*51 }
    
    it { should_not be_valid }
  end
  
  describe "email should be correct format" do
    before { player.email = "yo yo @ gmail com"}
    
    it { should_not be_valid }
  end
  
  describe "when password is not present" do
    before { player.password = player.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { player.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { player.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  describe "with a password that's too short" do
    before { player.password = player.password_confirmation = "a"*5 }
    it { should_not be_valid }
  end
  
  describe "return value of authenticate method" do
    before { player.save }
    let(:found_player) { Player.find_by_email(player.email) }
    
    describe "with valid password" do
      it { should == found_player.authenticate(player.password) }
    end
    
    describe "with invalid password" do
      let(:player_for_invalid_password) { found_player.authenticate("invalid") }
      it { should_not == player_for_invalid_password }
      specify { player_for_invalid_password.should be_false }
    end
  end
  
end
