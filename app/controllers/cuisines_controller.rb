class CuisinesController < ApplicationController
  def index
    respond_with Cuisine.all
  end

  def show
    cuisine = Cuisine.find(params[:id])
    respond_with cuisine.as_json.merge({
        places: cuisine.places
    })
  end
end
