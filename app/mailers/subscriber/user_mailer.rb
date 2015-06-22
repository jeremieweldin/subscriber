module Subscriber
  class UserMailer < ApplicationMailer

    # Subject can be set in your I18n file at config/locales/en.yml
    # with the following lookup:
    #
    #   en.user_mailer.password_reset.subject
    #
    default from: '"rankedHiRe Support" <support@rankedhire.com>'
    
    def sign_up_success(user)
      @user = user
      @inviter = User.find(user.organization.try(:owner_id)) if user.organization
      p "*******************************"
      p @user.password
      mail :to => user.email, :subject => "You’ve Been Invited To Join rankedHiRe"
    end

    def vendor_sign_up_success(user)
      @user = user
      @inviter = @user.member.account.owner
      @subdomain = @user.member.account.subdomain
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

    def approval_email(user)
      @user = user
      mail :to => "support@rankedhire.com", :subject => "A New User Has Signed Up"
    end

    def password_reset(user)
      @user = user
      mail :to => user.email, :subject => "Password Reset"
    end
  end
end
