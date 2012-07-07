require 'spec_helper'

describe "Player pages" do
  
  subject { page }
  
  describe "signup page" do
    before { visit signup_path }
    
    it { should have_selector('h1', text: 'Sign up') }
    it { should have_selector('title', text: 'Sign up') }
  end
  
  describe "profile page" do
    let(:player) { FactoryGirl.create(:player) }
    before { visit player_path(player) }

    it { should have_selector('h1',    text: player.player_name) }
    it { should have_selector('title', text: player.player_name) }
  end
  
  describe "signup" do

      before { visit signup_path }

      let(:submit) { "Create my account" }

      describe "with invalid information" do
        it "should not create a user" do
          expect { click_button submit }.not_to change(Player, :count)
        end
      end

      describe "with valid information" do
        before do
          fill_in "Player name",  with: "Example User"
          fill_in "Email",        with: "user@example.com"
          fill_in "Password",     with: "foobar"
          fill_in "Password confirmation", with: "foobar"
        end

        it "should create a user" do
          expect { click_button submit }.to change(Player, :count).by(1)
        end
        
        describe "after saving the player" do
          before { click_button submit }
          let(:player) { Player.find_by_email('user@example.com') }

          it { should have_selector('title', text: player.player_name) }
          it { should have_selector('div.alert.alert-success', text: 'Welcome') }
          it { should have_link('Sign out') }
          
        end


      end
    end
  
end
