class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    respond_with user.as_json.merge({
        reviews: user.reviews.map do |review|
          review.as_json.merge({
              place: review.place
          })
        end
    })
  end

  def create
    User.new(name: params[:name])
  end
end
