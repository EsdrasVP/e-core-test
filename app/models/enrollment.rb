# This model was created in order to manage the many-to-many relation between users and teams.
# It allows us to have a user with multiple roles across the teams
class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :role

  validates :user_id, uniqueness: { scope: [:team_id] }
  validates :user_id, :team_id, :role_id, presence: true

  before_validation :set_default_role, on: :create

  private

  # This could very well be a default value in the migration, but I chose to keep it at validation level
  # because if anyone wants to change the default role later they only need to change the following method
  # and not the migration itself
  def set_default_role
    if self.role_id.nil?
      default_role = Role.find_by(name: 'Developer')
      self.role_id = default_role.id if default_role
    end
  end
end
