class User < ActiveRecord::Base
  include Hateoas
  has_secure_password

  has_many :reviews, inverse_of: :user

  validates :name, presence: true

  def as_json(options = {})
    options[:except] = [:password_digest]
    super options
  end
end
