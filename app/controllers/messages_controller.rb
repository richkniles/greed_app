
class MessagesController < ApplicationController

  skip_before_filter :tweek_current_player
  before_filter :must_be_signed_in
  
  # grab and delete the first message
  def index 
    @message = Message.where("to_player = ?", current_player.id).first
    @message.destroy if @message
    render json: @message
  end
  
  # create a new message
  def create
    to_player = Player.find(params[:to])
    message = params[:message]
    current_player.send_message_to(to_player, message);
    render nothing: true
  end

  private
  
    def must_be_signed_in
      render status: :forbidden unless signed_in?
    end
end
