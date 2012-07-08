require 'spec_helper'

describe "User index page" do
  subject { page }
  
  describe "proper display of active users" do
  
    let!(:player) {FactoryGirl.create(:player)}
    before do 
      3.times { p = FactoryGirl.create(:player) }
      3.times do
        sign_in (p=FactoryGirl.create(:player))
      end
      sign_in player  # last player signed in is current_player
      visit players_path
    end
  
    it { should have_selector("title", text: "Active Players") }
    it { should have_selector("h1", text: "Active Players") }
  
    it "should list only active players" do
      Player.all.each do |p|
        if (p.last_active != nil && p.last_active >= 1.minute.ago && p != player) 
          page.should have_selector('li', text: p.player_name)
        else
          page.should_not have_selector('li', text: player.player_name)
        end
      end
    end
  end
  
  describe "clicking on a user should create a game" do
    let!(:player)       { FactoryGirl.create(:player) }
    let!(:other_player) { FactoryGirl.create(:player) }
    before do
      sign_in other_player
      sign_in player  # last player signed in is current_player
      visit players_path
    end
    
    it "should create a game when you click on a player" do
      click_button other_player.player_name
    
      page.should have_selector('title', text: "Play Greed with #{other_player.player_name}") 
    end
   
  end
 
end
