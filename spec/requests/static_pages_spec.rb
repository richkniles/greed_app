require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Welcome to Greed'" do
      visit '/static_pages/home'
      page.should have_content('Welcome to Greed')
    end
    
    it "should have the base title" do
      visit '/static_pages/home'
      page.should have_selector('title', text: "Greed - the game of strategy")     
    end 
  end
  
  describe "Help page" do

    it "should have the content 'Help Playing Greed'" do
      visit '/static_pages/help'
      page.should have_content('Help Playing Greed')
    end
    
    it "should have the title 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('title', text: "Greed - the game of strategy | Help")     
    end 
  end
  
  describe "About page" do

    it "should have the content 'About Greed'" do
      visit '/static_pages/about'
      page.should have_content('About Greed')
    end
    
    it "should have the title 'About'" do
      visit '/static_pages/about'
      page.should have_selector('title', text: "Greed - the game of strategy | About")     
    end 
  end
  
  
end
