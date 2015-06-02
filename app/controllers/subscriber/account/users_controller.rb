require_dependency "subscriber/application_controller"
require "ruby_identicon"
module Subscriber
  class Account::UsersController < ApplicationController
    def new
      @user = Subscriber::User.new(params[:user])
      @user.build_organization
    end

    def create
      account = Subscriber::Account.find_by!(:subdomain => request.subdomain)
      p user_params[:organization_attributes][:name]
      organization = Subscriber::Organization.where(name: user_params[:organization_attributes][:name], org_type: user_params[:organization_attributes][:org_type])
      if organization.any?
        params[:user].delete(:organization_attributes)
        @user = account.users.create(user_params)
        if @user.valid?
          @user.organization = organization.last
          @user.member.organization_id = organization.last.id
          @user.member.save!
          @user.save!
          @user.reload
          @user.send_signup_email
          force_authentication!(@user)
          flash[:success] = "You have signed up successfully."
          redirect_to root_path
        else
          flash[:error] = @user.errors.full_messages
          render action: 'new'
        end
      else
        @user = account.users.create(user_params)
        if @user.valid?
          @user.organization.owner_id = @user.id
          @user.organization.avatar = "data:image/png;base64,#{RubyIdenticon.create_base64(SecureRandom.base64(16).tr('+/=lIO0', 'pqrsxyz'))}"
          @user.member.organization_id = @user.organization.id
          @user.organization.save!
          @user.member.save!
          @user.organization.reload
          # @user.organization.send_signup_email
          @user.send_approval_email
          force_authentication!(@user)
          flash[:success] = "You have signed up successfully."
          redirect_to root_path
        else
          flash[:error] = @user.errors.full_messages
          render action: 'new'
        end
        p @user.member
      end
    end

    def edit
      @user = Subscriber::User.find(params[:id])
    end

    def update
      @user = Subscriber::User.find(params[:id])
      if @user.update_attributes(user_params)
        flash[:success] = "Profile updated."
        redirect_to edit_user_path
      else
        flash[:error] = "Profile could not be updated."
        redirect_to edit_user_path
      end
    end

    private
      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :full_name, {:organization_attributes => [
          :name, :org_type, :industry, :city, :state, :description, :employees
        ]})
      end
  end
end
