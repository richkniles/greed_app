
class MessagesController < ApplicationController

  before_filter :must_be_signed_in
  
  # grab and delete the first message
  def index 
    @message = Message.where("to_player = ?", current_player.id).first
    @message.destroy if @message
    render json: (@message ? @message.message : "nil")
  end
  
  # create a new message
  def create
    opponent = Player.find(params[:opponent])
    message = params[:message]
    current_player.send_message_to(opponent, message);
    render nothing: true
  end

  private
  
    def must_be_signed_in
      render status: :forbidden unless signed_in?
    end
end
