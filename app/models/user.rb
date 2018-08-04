class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications
  before_create :setup_activation
	after_create :send_activation_needed_email!
end
