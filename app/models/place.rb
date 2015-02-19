require 'elasticsearch/model'

class Place < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include Hateoas

  has_many :reviews, dependent: :destroy, inverse_of: :place
  has_and_belongs_to_many :cuisines
  geocoded_by :address

  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true

  after_validation :geocode, if: :address_changed?

  # Aggregates and saves the mean rating of all reviews
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

  # Configure Elasticsearch
  mapping do
    indexes :location, type: 'geo_point'
  end

  def as_indexed_json(options={})
    json = as_json(only: [:name, :description, :street, :city, :zip, :telephone, :homepage, :rating])
        .merge({
            location: { lat: self.latitude, lon: self.longitude },
            cuisines: cuisines.map(&:name),
        })

    json[:rating] = 2.5 if json[:rating].nil?
    json
  end
  # End configure Elasticsearch

  def self.search(name, location = nil)
    query = {
        query: {
            function_score: {
                query: {
                    bool: {
                        should: [
                            { match: { name: name }},
                            { match: { _all: {
                                query: name,
                                operator: 'or',
                                fuzziness: 'auto',
                                zero_terms_query: 'all'
                            }}}
                        ]
                    }
                },
                functions: [
                    { exp: { rating: { origin: 5, scale: 1, offset: 0.1 }}}
                ]
            }
        }
    }

    unless location.nil?
      query[:query][:function_score][:functions] += [
          { gauss: { location: { origin: location, scale: '250m', offset: '50m' }}},
          { gauss: { location: { origin: location, scale: '1km', offset: '550m' }}},
      ]
    end

    puts JSON.generate query

    response = __elasticsearch__.search query
    response.records.to_a
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
