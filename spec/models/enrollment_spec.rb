require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  let(:user) { User.create(external_id: '0e378b61-9cca-478b-97d2-a055792e596b', display_name: 'John Doe') }
  let(:team) { Team.create(external_id: '1e6da77f-dc6f-4994-b399-47626db9cd28', name: 'Development Team') }
  let(:role) { Role.create(name: 'Tester') }

  it 'is valid with valid attributes' do
    enrollment = Enrollment.new(user: user, team: team, role: role)
    expect(enrollment).to be_valid
  end

  it 'is invalid without a user' do
    enrollment = Enrollment.new(team: team, role: role)
    expect(enrollment).to_not be_valid
  end

  it 'is invalid without a team' do
    enrollment = Enrollment.new(user: user, role: role)
    expect(enrollment).to_not be_valid
  end

  it 'is invalid without a role' do
    enrollment = Enrollment.new(user: user, team: team)
    expect(enrollment).to_not be_valid
  end

  it 'enforces uniqueness of user and team combination' do
    Enrollment.create(user: user, team: team, role: role)
    duplicate_enrollment = Enrollment.new(user: user, team: team, role: role)
    expect(duplicate_enrollment).to_not be_valid
  end

  it 'defaults to Developer role if none is provided' do
    default_role = Role.find_by(name: 'Developer')
    enrollment = Enrollment.create(user: user, team: team)
    expect(enrollment.role).to eq(default_role)
  end
end