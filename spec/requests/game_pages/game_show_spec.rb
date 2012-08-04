require 'spec_helper'

describe "Game Show Page" do
  
	# create some players and a game
	let (:player1) { FactoryGirl.create(:player) }
	let (:player2) { FactoryGirl.create(:player) }
	let (:game)  { Game.create(player1: player1.id, player2: player2.id, state: Game::WAITING) }
	
	
	describe "The game show page" do

    before do
      sign_in player1
	    game.next_turn
  	  visit  "/games/#{game.id}" 
    end
    
	  it "should have the right header and title" do
      page.should have_selector('h1', text: "Game with #{player2.player_name}") 
      page.should have_selector('title', text: "Game with #{player2.player_name}")  
    end
    
    it "should have the score table" do
      page.should have_selector('td', text: "Your score")
      page.should have_selector('td', text: "#{player2.player_name}'s score")
    end
    
    # pusher isn't compatible with rspec
    # it "should respond to clicking the roll button" do
    #   click_button "Roll"
    #   turn_score = game.turns(1).last.score
    #   roll_score = game.turns(1).last.rolls.last.score
    #   page.should have_content("This roll: #{roll_score} This turn: #{turn_score}")
    # end
  end

end