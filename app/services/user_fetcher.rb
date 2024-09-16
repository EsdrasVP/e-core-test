class UserFetcher
  def initialize
    @url = ENV["EXTERNAL_USERS_URL"]
  end

  def call
    users = JSON.parse(Faraday.get(@url).body)

    users.map { |user| User.find_or_create_by(external_id: user["id"], display_name: user["displayName"]) }
  end
end
