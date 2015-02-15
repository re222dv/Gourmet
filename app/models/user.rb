class User < ActiveRecord::Base
  has_many :reviews, inverse_of: :user

  validates :name, presence: true
end
