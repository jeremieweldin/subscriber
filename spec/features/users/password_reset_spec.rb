require "rails_helper"
require 'subscriber/testing_support/subdomain_helpers'
require "subscriber/testing_support/factories/account_factory"
require "subscriber/testing_support/factories/user_factory"

feature "User password reset" do
  extend Subscriber::TestingSupport::SubdomainHelpers
  let!(:account) { FactoryGirl.create(:account) }
  let(:sign_in_url) { "http://#{account.subdomain}.example.com/sign_in" }
  let(:root_url) { "http://#{account.subdomain}.example.com/" }
  
  within_account_subdomain do
    scenario "sends password reset" do
      visit root_url
      expect(page.current_url).to eq(sign_in_url)
      click_link "forgot password?"
      expect(page).to have_content("Forgot password")
      fill_in "Email", :with => account.owner.email
      click_button "Reset Password"
      expect(page).to have_content("Email sent with password reset instructions.")
      expect(page.current_url).to eq(sign_in_url)
    end
  end

end