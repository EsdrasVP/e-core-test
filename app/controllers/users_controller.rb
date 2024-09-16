class UsersController < ApplicationController
  def import
    users = UserFetcher.new.call

    render json: users, status: :ok
  rescue StandardError => e
    render json: e, status: :unprocessable_entity
  end

  def index
    render json: User.all
  end

  def show
    user = User.find(params[:id])

    render json: user
  end
end
