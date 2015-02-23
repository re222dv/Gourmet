class UsersController < ApplicationController
  skip_before_action :validate_user

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
    puts params.inspect
    user = User.new user_parameters
    if user.save
      respond_with user, status: 201, location: user_path(user)
    else
      bad_request user.errors, location: nil
    end
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
