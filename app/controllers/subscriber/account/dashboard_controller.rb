require_dependency "subscriber/application_controller"

module Subscriber
  class Account::DashboardController < ApplicationController
    before_filter :authenticate_user!
  end
end
