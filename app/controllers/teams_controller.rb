class TeamsController < ApplicationController
  def import
    teams = TeamFetcher.new.call

    render json: teams, status: :ok
  rescue StandardError => e
    render json: e, status: :unprocessable_entity
  end

  def index
    render json: Team.all
  end

  def show
    team = Team.find(params[:id])

    render json: team
  end
end
