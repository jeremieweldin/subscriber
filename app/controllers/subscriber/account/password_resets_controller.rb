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

    def show
      
    end

    def edit
      @user = Subscriber::User.find_by!(password_reset_token: params[:id])
    end

    def update
      @user = Subscriber::User.find_by!(password_reset_token: params[:id])
      p @user
      if @user.password_reset_sent_at < 2.hours.ago
        flash[:error] = "Password reset has expired."
        redirect_to new_password_reset_path
      elsif @user.update_attributes(password_params[:user])
        flash[:success] = "Password has been reset!"
        redirect_to sign_in_path
      else
        render :edit
      end
    end

    private
      def password_params
        params.permit(:user => [:password, :password_confirmation])
      end
  end
end
