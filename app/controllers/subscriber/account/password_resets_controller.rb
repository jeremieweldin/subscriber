require_dependency "subscriber/application_controller"

module Subscriber
  class Account::PasswordResetsController < ApplicationController

    def new
    end
    
    def create
      user = Subscriber::User.find_by_email(params[:email]) 
      if user
        user.send_password_reset
        flash[:notice] = "Email sent with password reset instructions."
        redirect_to sign_in_path
      else
        flash[:error] = "Couldn't find email #{params[:email]}."
        render :action => "new"
      end
    end

    def edit
      @user = Subscriber::User.find_by_password_reset_token!(params[:id])
    end

    def update
      @user = Subscriber::User.find_by_password_reset_token!(params[:id])
      if @user.password_reset_sent_at < 2.hours.ago
        redirect_to new_password_reset_path, :alert => "Password reset has expired."
      elsif @user.update_attributes(params[:user])
        redirect_to root_path, :notice => "Password has been reset!"
      else
        render :edit
      end
    end
  end
end
