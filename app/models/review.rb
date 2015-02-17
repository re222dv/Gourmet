class Review < ActiveRecord::Base
  include Hateoas

  belongs_to :place, inverse_of: :reviews
  belongs_to :user, inverse_of: :reviews

  validates :place, presence: true
  validates :user, presence: true
  validates :rating, presence: true, numericality: true, inclusion: 1..5

  after_commit { place.update_rating }
end
