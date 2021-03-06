class ReviewsController < ApplicationController
  def index
    if params.has_key? :place_id
      reviews = paginate Review.where(place_id: params[:place_id]).order('updated_at DESC'), true
      reviews.items = reviews.items.map do |review|
        review.as_json.merge({
            user: review.user.as_json
        })
      end
    elsif params.has_key? :user_id
      reviews = paginate Review.where(user_id: params[:user_id]).order('updated_at DESC'), true
      reviews.items = reviews.items.map do |review|
        review.as_json.merge({
            place: review.place.as_json
        })
      end
    else
      return bad_request
    end
    respond_with reviews.as_json
  end

  def show
    review = Review.where(place_id: params[:place_id], id: params[:id]).first
    respond_with review.as_json.merge({
        user: review.user.as_json,
        place: review.place.as_json
    })
  end

  def create
    review = Review.new review_parameters
    if review.save
      respond_with review, status: 201, location: place_review_path(review.place_id, review)
    else
      bad_request review.errors, location: nil
    end
  end

  def update
    review = Review.find params[:id]
    if review.user_id == @current_user.id
      if review.update_attributes review_parameters
        respond_with review
      else
        bad_request review.errors
      end
    else
      forbidden
    end
  end

  def destroy
    review = Review.find params[:id]
    if review.user_id == @current_user.id
      review.destroy
      respond_with nil
    else
      forbidden
    end
  end

  private

  def review_parameters
    if params.has_key? :review
      review = params[:review]
    else
      review = params
    end
    place = Place.find(params[:place_id])
    {
        description: review[:description],
        rating: review[:rating],
        place: place,
        user: @current_user,
    }
  end
end
