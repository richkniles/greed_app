require 'spec_helper'

describe "Authentication" do
  
  subject { page }
  
  describe "signin page" do
    before { visit signin_path }
    
    it { should have_selector('h1',     text: 'Sign in') }
    it { should have_selector('title',  text: 'Sign in') }
  end
  
  describe "signin" do
      before { visit signin_path }

      describe "with invalid information" do
        before { click_button "Sign in" }

        it { should have_selector('title', text: 'Sign in') }
        it { should have_selector('div.alert.alert-error', text: 'Invalid') }

        describe "after visiting another page" do
          before { click_link "Home" }
          it { should_not have_selector('div.alert.alert-error') }
        end

      end

      describe "with valid information" do
        let(:player) { FactoryGirl.create(:player) }
        before do
          fill_in "Email",    with: player.email
          fill_in "Password", with: player.password
          click_button "Sign in"
        end

        it { should have_selector('title', text: player.player_name) }
        it { should have_link('Profile', href: player_path(player)) }
        it { should have_link('Sign out', href: signout_path) }
        it { should_not have_link('Sign in', href: signin_path) }

        describe "followed by signout" do
          before { click_link "Sign out" }
          it { should have_link('Sign in') }
        end

      end
      
      describe "keeping last active up to date" do
        let(:player) { FactoryGirl.create(:player) }
        let!(:time) { Time.zone.now }
        before do
          fill_in "Email",    with: player.email
          fill_in "Password", with: player.password
          click_button "Sign in"
        end

        it "should update last_active when visit the root path" do
          visit root_path          
          current_player = Player.find_by_email(player.email)
          current_player.last_active.should_not be_nil
          current_player.last_active.should >= time
        end
        it "should update last_active when visit the about path" do
          visit about_path          
          current_player = Player.find_by_email(player.email)
          current_player.last_active.should_not be_nil
          current_player.last_active.should >= time
        end
        it "should update last_active when visit the rules path" do
          visit rules_path          
          current_player = Player.find_by_email(player.email)
          current_player.last_active.should_not be_nil
          current_player.last_active.should >= time
        end
        it "should nil out last_active on sign_out" do
          click_link "Sign out"
          current_player = Player.find_by_email(player.email)
          current_player.last_active.should be_nil
        end
      end

    end 
end
