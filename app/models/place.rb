class Place < ActiveRecord::Base
  has_many :reviews, dependent: :destroy, inverse_of: :place
  has_and_belongs_to_many :cuisines
  geocoded_by :address

  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true

  after_validation :geocode, if: :address_changed?

  private

  def address
    [street, city, 'Sweden'].compact.join(', ')
  end

  def address_changed?
    return false unless errors.empty?
    street_changed? || city_changed?
  end
end
