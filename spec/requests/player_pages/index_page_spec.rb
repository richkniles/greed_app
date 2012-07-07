require 'spec_helper'

describe "User index page" do
  subject { page }
  
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
