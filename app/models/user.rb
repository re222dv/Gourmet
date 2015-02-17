class User < ActiveRecord::Base
  include Hateoas

  has_many :reviews, inverse_of: :user

  validates :name, presence: true
end
