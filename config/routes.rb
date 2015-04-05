require "subscriber/constraints/subdomain_required"

Subscriber::Engine.routes.draw do
  constraints(Subscriber::Constraints::SubdomainRequired) do
    scope :module => "account" do
      root :to => "dashboard#index", :as => :account_root 
      get "/sign_in", :to => "sessions#new", :as => :sign_in
      post "/sign_in", :to => "sessions#create", :as => :sessions
      get "/sign_up", :to => "users#new", :as => :user_sign_up
      post "/sign_up", :to => "users#create", :as => :do_user_sign_up
      delete "/sign_out", :to => "sessions#destroy", :as => :sign_out
      get "/users/:id/edit", :to => "users#edit", :as => :edit_user
      patch "/users/:id/edit", :to => "users#update"
      resources :password_resets, only: [:new, :create, :edit, :update]
      # get "/password_reset", :to => "password_resets#new", :as => :password_reset
      # post "/password_reset", :to => "password_resets#create", :as => :do_password_reset
      
    end
  end

  root "dashboard#index"
  get "/sign_up", :to => "accounts#new", :as => :sign_up
  post "/accounts", :to => "accounts#create", :as => :accounts
end
