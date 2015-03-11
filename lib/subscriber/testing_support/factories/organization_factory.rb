FactoryGirl.define do
  factory :organization, :class => Subscriber::Organization do
    sequence(:name) { |n| "Test Organization ##{n}" } 
    org_type "Client"
  end 
end