require_dependency "subscriber/application_controller"

module Subscriber
  class Account::UsersController < ApplicationController
    def new
      @user = Subscriber::User.new
      @user.build_organization
    end

    def create
      account = Subscriber::Account.find_by!(:subdomain => request.subdomain)
      p user_params[:organization_attributes][:name]
      organization = Subscriber::Organization.where(name: user_params[:organization_attributes][:name], org_type: user_params[:organization_attributes][:org_type])
      if organization.any?
        params[:user].delete(:organization_attributes)
        @user = account.users.create(user_params)
        if @user.save
          @user.organization = organization.last
          @user.member.organization_id = organization.last.id
          @user.member.save!
          force_authentication!(@user)
          flash[:success] = "You have signed up successfully."
          redirect_to root_path
        else
          flash[:error] = "Sorry, sign up unsuccessful."
          render :new 
        end
      else
        @user = account.users.create(user_params)
        if @user.valid?
          @user.member.organization_id = @user.organization.id
          @user.member.save!
          force_authentication!(@user)
          flash[:success] = "You have signed up successfully."
          redirect_to root_path
        else
          flash[:error] = "Sorry, sign up unsuccessful."
          render :new 
        end
        p @user.member
      end
    end

    private
      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, {:organization_attributes => [
          :name, :org_type
        ]})
      end
  end
end
