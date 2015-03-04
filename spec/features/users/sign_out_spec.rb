require "rails_helper"
require "subscriber/testing_support/factories/account_factory"
require "subscriber/testing_support/factories/user_factory"

feature "User signout" do
  
  let!(:account) { FactoryGirl.create(:account) }
  let!(:user) { FactoryGirl.create(:user) }
  let(:root_url) { "http://#{account.subdomain}.example.com/" }
  let(:sign_in_url) { "http://#{account.subdomain}.example.com/sign_in" }
  
  scenario "sign out user" do 
    sign_in_as(:user => user, :account => account) 
    visit root_url
    expect(page).to have_content("Sign out")
    click_link "Sign out"
    expect(page).to have_content("Please sign in.")
    expect(page.current_url).to eq(sign_in_url)
  end
end