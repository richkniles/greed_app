require 'pusher'


class PusherMessageController < ApplicationController
  
  include PusherKeys
  
  def new
  end
  
  def create
    
    channel = Player.find(params[:to]).player_name
    
    message_packet = {
                        fr_id: current_player.id.to_s, 
                        to_id: params[:to], 
                        message: params[:message]
                      }.to_json

    Pusher.app_id = PusherKeys::APP_ID
    Pusher.key = PusherKeys::APP_KEY
    Pusher.secret = PusherKeys::APP_SECRET
    
    Pusher[channel].trigger('game-action', {:message => message_packet})
    
    render new
  end
  
end
