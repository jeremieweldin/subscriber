module Subscriber
  class UserMailer < ApplicationMailer

    # Subject can be set in your I18n file at config/locales/en.yml
    # with the following lookup:
    #
    #   en.user_mailer.password_reset.subject
    #
    
    def sign_up_success(user)
      @user = user
      @inviter = User.find(user.organization.try(:owner_id))
      p "*******************************"
      p @user.password
      mail :to => user.email, :subject => "You’ve Been Invited To Join rankedHiRe"
    end

    def sign_up_agency_success(user)
      @user = user
      mail :to => user.email, :subject => "Placing More Talent with rankedHiRe"
    end

    def sign_up_client_success(user)
      @user = user
      mail :to => user.email, :subject => "Finding the Best Talent with rankedHiRe"
    end

    def password_reset(user)
      @user = user
      mail :to => user.email, :subject => "Password Reset"
    end
  end
end
