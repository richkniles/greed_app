include ApplicationHelper

def sign_in(player)
  visit signin_path
  fill_in "Email",    with: player.email
  fill_in "Password", with: player.password
  click_button "Sign in"
end