require_dependency "subscriber/application_controller"

module Subscriber
  class Account::UsersController < ApplicationController
    def new
      @user = Subscriber::User.new
    end

    def create
      account = Subscriber::Account.find_by!(:subdomain => request.subdomain) 
      user = account.users.create(user_params)
      force_authentication!(account, user)
      flash[:success] = "You have signed up successfully."
      redirect_to root_path
    end

    private
      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
  end
end
