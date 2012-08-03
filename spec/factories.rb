FactoryGirl.define do
  factory :player do
    sequence(:player_name) { |n| "Player #{n}"}
    sequence(:email)       { |n| "player#{n}@email.com" }
    password              "foobar"
    password_confirmation "foobar"
  end
end