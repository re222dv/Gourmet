class User < ActiveRecord::Base
  include Hateoas
  has_secure_password

  has_many :reviews, inverse_of: :user

  validates :name, presence: true
end
