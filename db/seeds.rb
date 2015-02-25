# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'json'
require 'net/http'

Encoding.default_external = Encoding::UTF_8

pizza = Cuisine.create!(
  name: 'Pizza'
)

data = File.readlines('myfile.out').join
data = JSON.parse data

data.each do |d|
  place = d['results']['collection1'][0]
  restaurant = Place.where(name: place['Name']).first
  next if restaurant.present?

  if place['Image']['src'] == 'http://www.allakartor.se/graphics/no_image_100.gif'
    image = nil
  else
    image = place['Image']['src'].tr('venue_images_100', 'venue_images_475')
  end

  restaurant = Place.create!(
      name: place['Name'],
      street: place['Street'],
      zip: place['Zip'],
      city: place['City'],
      telephone: place['Tel'],
      description: place['Description'],
      image_url: image,
  )

  restaurant.cuisines << pizza if restaurant.description.downcase.include? 'pizz'

  d['results']['collection3'].each do |review|
    next if review['ReviewName']['text'].empty?

    user = User.where(name: review['ReviewName']['text']).first
    if user.nil?
      user = User.create!(
        name: review['ReviewName']['text'],
        password: 'seed'
      )
    end
    Review.create!(
      place: restaurant,
      user: user,
      rating: review['ReviewRate'].split(' ').last.to_i,
      description: review['ReviewTest'],
      created_at: Time.parse(review['ReviewDate']),
    )
  end

  sleep 0.25
end


User.create!(
    name: 'test',
    password: 'test'
)
