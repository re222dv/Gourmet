class PlacesController < ApplicationController
  def index
    if params.has_key? :cuisine_id
      respond_with Cuisine.find(params[:cuisine_id]).places
    else
      respond_with Place.all
    end
  end

  def show
    place = Place.find(params[:id])
    respond_with place.as_json.merge({
        cuisines: place.cuisines,
        reviews: place.reviews.map do |review|
          review.as_json.merge({
              user: review.user
          })
        end
    })
  end
end
