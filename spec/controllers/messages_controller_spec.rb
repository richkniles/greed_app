require 'spec_helper'

describe MessagesController do

  describe "/messages" do
    describe "not signed in" do
      it "returns no success" do
        get 'index'
        response.should be_forbidden
      end 
    end
    
    describe "signed_in" do
      let(:player) { FactoryGirl.create(:player) }
      before { sign_in player }
      
      it "returns success" do
        get "index"
        response.should be_success
      end
    
      describe "fetching messages" do
        before { Message.create(from_player: 99, to_player: player.id, message: "heys") }
        it "get 'index' should reply with first message" do
          get 'index'
          response.body.should have_content("hey")
        end
        it "should remove the message on the first get" do
          get 'index'
          get 'index'
          response.body.should have_content("nil")
        end
      end
      
    end
      
  end
  

  # describe "GET 'create'" do
  #   it "returns http success" do
  #     get 'create'
  #     response.should be_success
  #   end
  # end


end
