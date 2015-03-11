require "rails_helper"
require "subscriber/testing_support/factories/account_factory"
require "subscriber/testing_support/factories/user_factory"
require "subscriber/testing_support/factories/organization_factory"

feature "User signup" do
  let!(:account) { FactoryGirl.create(:account) }
  let(:root_url) { "http://#{account.subdomain}.example.com/" } 
  
  scenario "under an account" do
    visit root_url
    expect(page.current_url).to eq(root_url + "sign_in")
    click_link "New User?"
    fill_in "Name", :with => "rankedHiRe"
    select "Client", :from => "Org type"
    fill_in "Email", :with => "user@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully.")
    expect(page).to have_content("rankedHiRe")
    expect(page.current_url).to eq(root_url)
  end

  scenario "ensure organization present" do
    Subscriber::Organization.create!(:name => "rankedHiRe", :org_type => "Client")
    visit root_url
    expect(page.current_url).to eq(root_url + "sign_in")
    click_link "New User?"
    fill_in "Name", :with => ""
    select "Client", :from => "Org type"
    fill_in "Email", :with => "user@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_button "Sign up"
    expect(page.current_url).to eq("http://#{account.subdomain}.example.com/sign_up")
    expect(page).to have_content("Sorry, sign up unsuccessful.")
  end
end