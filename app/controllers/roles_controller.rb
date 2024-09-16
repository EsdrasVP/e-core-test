class RolesController < ApplicationController
  def index
    render json: Role.all
  end

  def create
    role = Role.new(role_params)
    if role.save
      render json: role, status: :created
    else
      render json: role.errors, status: :unprocessable_entity
    end
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end
end
