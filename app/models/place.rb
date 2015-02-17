class Place < ActiveRecord::Base
  include Hateoas

  has_many :reviews, dependent: :destroy, inverse_of: :place
  has_and_belongs_to_many :cuisines
  geocoded_by :address

  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true

  after_validation :geocode, if: :address_changed?

  def update_rating
    # Get the amount of reviews from the database, discarding cache as a review just got written
    size = reviews(true).length
    initial = 0.0

    if size < 3 # Gear towards the middle if there are too few reviews
      initial = (3 - size) * 2.5
      size = 3
    end

    # Calculate the mean rating
    self.rating = reviews.inject(initial) { |sum, review| sum + review.rating } / size
    save
    rating
  end

  private

  def address
    [street, city, 'Sweden'].compact.join(', ')
  end

  def address_changed?
    return false unless errors.empty?
    street_changed? || city_changed?
  end
end
