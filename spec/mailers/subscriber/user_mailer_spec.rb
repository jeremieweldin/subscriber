require "rails_helper"
require "subscriber/testing_support/factories/user_factory"
require "subscriber/testing_support/factories/organization_factory"

module Subscriber
  RSpec.describe UserMailer, :type => :mailer do
    let!(:user) { FactoryGirl.create(:user) }
    describe "password_reset" do
      let(:mail) { UserMailer.password_reset(user) }

      it "renders the headers" do
        expect(mail.subject).to eq("Password Reset")
        expect(mail.to).to eq([user.email])
        expect(mail.from).to eq(["from@example.com"])
      end

      it "renders the body" do
        expect(mail.body.encoded).to match("To reset your password, click the URL below.")
      end
    end

    describe "sign_up_success" do
      let(:mail) { UserMailer.sign_up_success(user) }

      it "renders the headers" do
        expect(mail.subject).to eq("Welcome to rankedHire!")
        expect(mail.to).to eq([user.email])
        expect(mail.from).to eq(["from@example.com"])
      end

      it "renders the body" do
        expect(mail.body.encoded).to match("Welcome to rankedHiRe!")
      end
    end

  end
end
