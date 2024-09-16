class TeamFetcher
  def initialize
    @url = ENV["EXTERNAL_TEAMS_URL"]
  end

  def call
    teams = JSON.parse(Faraday.get(@url).body)

    teams.map { |team| Team.find_or_create_by(external_id: team["id"], name: team["name"]) }
  end
end
