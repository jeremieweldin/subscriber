Rails.application.routes.draw do

  mount Subscriber::Engine => "/subscriber"
end
