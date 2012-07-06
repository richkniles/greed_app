require 'spec_helper'

describe "Static pages" do

  subject { page }
  
  describe "Home page" do
    before { visit root_path }
    
    it { should have_content('The dice game of strategy') }
    
    it { should have_selector('title', text: "Greed - the game of strategy") }
  
  describe "Rules page" do
    before { visit rules_path }
    
    it { should have_content('Greed Game Rules') }
    
    it { should have_selector('title', text: "Greed - the game of strategy | Rules") }    
  end
  
  describe "About page" do
    before { visit about_path }
    
    it { should have_content('About Greed') }
    
    it { should have_selector('title', text: "Greed - the game of strategy | About") }    
  end
  
  describe "Contact page" do
    before { visit contact_path }
    
    it { should have_selector('h1', text: 'Contact') }
    
    it { should have_selector('title',
                    text: 'Greed - the game of strategy | Contact') }
    end
  end
  
end
