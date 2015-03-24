$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "subscriber/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "subscriber"
  s.version     = Subscriber::VERSION
  s.authors     = ["Abdul Miah"]
  s.email       = ["momun20@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Subscriber."
  s.description = "TODO: Description of Subscriber."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "bcrypt", "3.1.7"
  s.add_dependency "warden", "1.2.3"
  s.add_dependency "dynamic_form", "1.1.4"
  s.add_dependency "houser", "1.0.2"
  s.add_dependency "haml"
  s.add_dependency "haml-rails"
  s.add_dependency "ruby_identicon"
  
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "3.0.1"
  s.add_development_dependency "capybara", "2.3.0"
  s.add_development_dependency "factory_girl", "4.4.0"
  s.add_development_dependency "database_cleaner", "1.3.0"
  
end
