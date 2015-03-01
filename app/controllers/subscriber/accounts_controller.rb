require_dependency "subscriber/application_controller"

module Subscriber
  class AccountsController < ApplicationController
    def new
      @account = Subscriber::Account.new
      @account.build_owner
    end

    def create
      account = Subscriber::Account.create(account_params)
      p account.owner
      env["warden"].set_user(account.owner, :scope => :user)
      env["warden"].set_user(account, :scope => :account)
      flash[:success] = "Your account has been successfully created." 
      redirect_to subscriber.root_url
    end
    
    private
      def account_params
        params.require(:account).permit(:name, {:owner_attributes => [
          :email, :password, :password_confirmation
        ]})
      end
  end
end
