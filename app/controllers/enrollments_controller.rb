class EnrollmentsController < ApplicationController
  def create
    enrollment = Enrollment.new(enrollment_params)
    if enrollment.save
      render json: enrollment, status: :created
    else
      render json: enrollment.errors, status: :unprocessable_entity
    end
  end

  def find
    enrollment = Enrollment.find_by(user_id: params[:user_id], team_id: params[:team_id])
    if enrollment
      render json: enrollment
    else
      render json: { error: 'Enrollment not found' }, status: :not_found
    end
  end

  def index
    enrollments = Enrollment.where(role_id: params[:role_id])
    render json: enrollments
  end

  private

  def enrollment_params
    params.require(:enrollment).permit(:user_id, :team_id, :role_id)
  end
end