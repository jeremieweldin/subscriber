FactoryGirl.define do
  factory :user, :class => Subscriber::User do
    sequence(:email) { |n| "test#{n}@example.com" } 
    password "password"
    password_confirmation "password"
    password_reset_token "zxyb"
    password_reset_sent_at Time.now
    association :organization, :factory => :organization
  end 
end