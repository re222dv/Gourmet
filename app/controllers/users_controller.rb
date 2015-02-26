class UsersController < ApplicationController
  skip_before_action :validate_user, only: [:create]

  def show
    user = User.find(params[:id])
    respond_with user.as_json.merge({
        reviews: user.reviews.order('updated_at DESC').map do |review|
          review.as_json.merge({
              place: review.place.as_json
          })
        end
    })
  end

  def create
    user = User.new user_parameters
    if user.save
      respond_with user, status: 201, location: user_path(user)
    else
      bad_request user.errors, location: nil
    end
  end

  def update
    if params[:id].to_i != @current_user.id
      return forbidden
    end
    @current_user.password = params[:password]
    @current_user.save
    respond_with @current_user
  end

  private

  def user_parameters
    #if params.has_key? :user
    #  user = params[:user]
    #else
      user = params
    #end
    {
        name: user[:name],
        password: user[:password]
    }
  end
end
