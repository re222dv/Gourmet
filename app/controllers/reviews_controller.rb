class ReviewsController < ApplicationController
  def index
    reviews = nil
    if params.has_key? :place_id
      reviews = Review.where(place_id: params[:place_id]).map do |review|
        review.as_json.merge({
            user: review.user
        })
      end
    elsif params.has_key? :user_id
      reviews = Review.where(user_id: params[:user_id]).map do |review|
        review.as_json.merge({
            place: review.place
        })
      end
      puts reviews.inspect
    else
      return bad_request
    end
    respond_with reviews
  end

  def show
    review = Review.where(place_id: params[:place_id], id: params[:id]).first
    respond_with review.as_json.merge({
        user: review.user,
        place: review.place
    })
  end
end
