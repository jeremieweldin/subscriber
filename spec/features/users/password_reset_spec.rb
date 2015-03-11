require "rails_helper"
require 'subscriber/testing_support/subdomain_helpers'
require "subscriber/testing_support/factories/account_factory"
require "subscriber/testing_support/factories/user_factory"
require "subscriber/testing_support/factories/organization_factory"


feature "User password reset" do
  extend Subscriber::TestingSupport::SubdomainHelpers
  let!(:account) { FactoryGirl.create(:account) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user_exp) { FactoryGirl.create(:user, password_reset_sent_at: "2015-03-04 07:59:11 -0600", password_reset_token: "mnsls") }
  let(:sign_in_url) { "http://#{account.subdomain}.example.com/sign_in" }
  let(:password_reset_url) { "http://#{account.subdomain}.example.com/password_resets" }
  let(:edit_password_reset_url) { "http://#{account.subdomain}.example.com/password_resets/#{user.password_reset_token}/edit" }
  let(:edit_password_reset_url_exp) { "http://#{account.subdomain}.example.com/password_resets/#{user_exp.password_reset_token}/edit" }
  let(:root_url) { "http://#{account.subdomain}.example.com/" }
  
  scenario "sends password reset" do
    visit subscriber.root_url(:subdomain => account.subdomain) 
    expect(page.current_url).to eq(sign_in_url)
    click_link "forgot password?"
    expect(page).to have_content("Forgot password")
    fill_in "Email", :with => account.owner.email
    click_button "Reset Password"
    expect(page).to have_content("Email sent with password reset instructions.")
    expect(page.current_url).to eq(sign_in_url)
  end

  scenario "does not send password reset to unknown email" do
    visit subscriber.root_url(:subdomain => account.subdomain) 
    expect(page.current_url).to eq(sign_in_url)
    click_link "forgot password?"
    expect(page).to have_content("Forgot password")
    fill_in "Email", :with => "bazz@example.com"
    click_button "Reset Password"
    expect(page).to have_content("Couldn't find email bazz@example.com")
    expect(page.current_url).to eq(password_reset_url)
  end

  scenario "resets password if token is valid" do
    visit edit_password_reset_url
    expect(page).to have_content("Reset password")
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_button "Update Password"
    expect(page).to have_content("Password has been reset!")
    expect(page.current_url).to eq(sign_in_url)
  end

  scenario "does not reset password with invalid token" do
    visit edit_password_reset_url_exp
    expect(page).to have_content("Reset password")
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_button "Update Password"
    expect(page).to have_content("Password reset has expired.")
    expect(page.current_url).to eq("#{password_reset_url}/new")
  end

end