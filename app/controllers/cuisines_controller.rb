class CuisinesController < ApplicationController
  def index
    respond_with Cuisine.all.as_json
  end

  def show
    respond_with Cuisine.find(params[:id]).as_json
  end
end
