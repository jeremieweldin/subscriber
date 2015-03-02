ActiveRecord::Base.class_eval do 
  def self.scoped_to_account
    belongs_to :account, :class_name => "Subscriber::Account"
    association_name = self.to_s.downcase.pluralize
    Subscriber::Account.has_many association_name.to_sym, :class_name => self.to_s
  end 
end