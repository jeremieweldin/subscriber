require "rails_helper"
require "subscriber/testing_support/factories/user_factory"
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

  end
end
