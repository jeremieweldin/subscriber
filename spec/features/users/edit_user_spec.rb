require "rails_helper"
require "subscriber/testing_support/factories/account_factory"
require "subscriber/testing_support/factories/user_factory"

feature "User edit" do
  
  let!(:account) { FactoryGirl.create(:account) }
  let!(:user) { FactoryGirl.create(:user) }
  let(:root_url) { "http://#{account.subdomain}.example.com/" }
  let(:edit_user_url) { "http://#{account.subdomain}.example.com/users/#{user.id}/edit" }
  
  scenario "update user profile" do 
    sign_in_as(:user => user, :account => account) 
    visit edit_user_url
    expect(page).to have_content("Edit profile")
    fill_in "Email", :with => "buzz@example.com"
    click_button "Update profile"
    expect(page).to have_content("Profile updated.")
    expect(page.current_url).to eq(edit_user_url)
  end

  scenario "update user profile should fail" do 
    sign_in_as(:user => user, :account => account) 
    visit edit_user_url
    expect(page).to have_content("Edit profile")
    fill_in "Email", :with => "fizzbuzz"
    click_button "Update profile"
    #to-do: make validation messages show up
    expect(page).to have_content("Profile could not be updated.")
    expect(page.current_url).to eq(edit_user_url)
  end
end