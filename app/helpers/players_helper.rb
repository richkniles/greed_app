module PlayersHelper
  
  def gravatar_for(player)
    gravatar_id = Digest::MD5::hexdigest(player.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: player.player_name, class: "gravatar")
  end
  
end
