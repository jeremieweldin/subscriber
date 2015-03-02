module Subscriber
  require "warden"
  require "houser"
  require "dynamic_form"
  require "subscriber/active_record_extensions"

  class Engine < ::Rails::Engine
    isolate_namespace Subscriber
    
    config.to_prepare do
      root = Subscriber::Engine.root
      extenders_path = root + "app/extenders/**/*.rb" 
      Dir.glob(extenders_path) do |file|
        Rails.configuration.cache_classes ? require(file) : load(file) 
      end
    end

    config.generators do |g|
      g.test_framework :rspec, :view_specs => false 
    end

    initializer "subscriber.middleware.warden" do Rails.application.config.middleware.use Warden::Manager do |manager|
      manager.default_strategies :password
      
      manager.serialize_into_session do |user| 
        user.id
      end
      manager.serialize_from_session do |id|
        Subscriber::User.find(id) end
      end 
    end

    initializer 'subscriber.middleware.houser' do 
      Rails.application.config.middleware.use Houser::Middleware,
        :class_name => 'Subscriber::Account' 
    end
  end
end
