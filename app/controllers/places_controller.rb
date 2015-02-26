class PlacesController < ApplicationController
  def index
    if params.has_key? :cuisine_id
      respond_with paginate Cuisine.find(params[:cuisine_id]).places
    elsif params.has_key? :query
      respond_with Place.search(params[:query], params[:location])
    else
      respond_with paginate Place.all
    end
  end

  def show
    place = Place.find(params[:id])
    respond_with place.as_json.merge({
        cuisines: place.cuisines,
        reviews: place.reviews.order('updated_at DESC').map do |review|
          review.as_json.merge({
              user: review.user.as_json
          })
        end
    })
  end

  def create
    place = Place.new place_parameters
    if place.save
      respond_with place, status: 201, location: place_path(place)
    else
      bad_request place.errors, location: nil
    end
  end

  def update
    place = Place.find params[:id]
    if place.update_attributes place_parameters
      respond_with place
    else
      bad_request place.errors
    end
  end

  private

  def place_parameters
    if params.has_key? :place
      place = params[:place]
      if place.has_key? :cuisines
        place[:cuisines] = place[:cuisines].values
      end
    else
      place = params
    end
    cuisines = Cuisine.where(name: place[:cuisines])
    {
        name: place[:name],
        description: place[:description],
        street: place[:street],
        city: place[:city],
        zip: place[:zip],
        telephone: place[:telephone],
        homepage: place[:homepage],
        image_url: place[:image_url],
        cuisines: cuisines,
    }
  end
end
