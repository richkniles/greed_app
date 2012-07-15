require 'spec_helper'

describe Message do
  
  let(:message) { Message.new(from_player: 1, to_player: 2, message: "some text") }
  
  subject { message }
  
  it { should respond_to :from_player }  
  it { should respond_to :to_player }
  it { should respond_to :message }
  it { should be_valid }
  
  describe "should not be valid with missing attributes" do
    describe "without from" do
      before { message.from_player = nil }
      it { should_not be_valid }
    end
  
  
    describe "without to" do
      before { message.to_player = nil }
      it { should_not be_valid }
    end
  
    describe "without message" do
      before { message.message = " " }
      it { should_not be_valid }
    end
    
  end
  
  describe "players should be able to send messages to other players" do
    
    let(:player1) { FactoryGirl.create(:player) }
    let(:player2) { FactoryGirl.create(:player) }
    
    it "should increment the message count" do
      expect do 
        player1.send_message_to(player2, "Hey")
      end.should change(Message, :count).by 1
    end
    
  end
  
  describe "messages should be FIFO" do
    let!(:message1) { Message.create(from_player: 1, to_player: 2, message: "x") }
    let!(:message2) { Message.create(from_player: 1, to_player: 2, message: "y") }    
    
    it "after changing created_at first message should be message2" do
      message1.created_at = 1.second.from_now
      message1.save;
      Message.first.message.should == 'y'
    end
    
  end
  
end
