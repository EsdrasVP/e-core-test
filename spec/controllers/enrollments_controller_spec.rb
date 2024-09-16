require 'rails_helper'

RSpec.describe EnrollmentsController, type: :controller do
  let(:user) { User.create(external_id: '0e378b61-9cca-478b-97d2-a055792e596b', display_name: 'John Doe') }
  let(:team) { Team.create(external_id: '1e6da77f-dc6f-4994-b399-47626db9cd28', name: 'Development Team') }
  let(:role) { Role.create(name: 'Tester') }
  let(:valid_attributes) { { user_id: user.id, team_id: team.id, role_id: role.id } }
  let(:invalid_attributes) { { user_id: nil, team_id: team.id, role_id: role.id } }

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Enrollment' do
        expect {
          post :create, params: { enrollment: valid_attributes }
        }.to change(Enrollment, :count).by(1)
      end

      it 'renders a JSON response with the new enrollment' do
        post :create, params: { enrollment: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to include('application/json')
        expect(JSON.parse(response.body)['user_id']).to eq(user.id)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new enrollment' do
        expect {
          post :create, params: { enrollment: invalid_attributes }
        }.to change(Enrollment, :count).by(0)
      end

      it 'renders a JSON response with errors for the new enrollment' do
        post :create, params: { enrollment: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
        expect(JSON.parse(response.body)['user']).to include("must exist")
      end
    end
  end

  describe 'GET #find' do
    let!(:enrollment) { Enrollment.create(user: user, team: team, role: role) }

    it 'renders a JSON response with the enrollment' do
      get :find, params: { user_id: user.id, team_id: team.id }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(JSON.parse(response.body)['user_id']).to eq(user.id)
    end

    it 'renders a 404 error if the enrollment is not found' do
      get :find, params: { user_id: 999, team_id: 999 }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq('Enrollment not found')
    end
  end

  describe 'GET #index' do
    let!(:enrollment) { Enrollment.create(user: user, team: team, role: role) }

    it 'renders a JSON response with a list of enrollments for the given role' do
      get :index, params: { role_id: role.id }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(JSON.parse(response.body).first['user_id']).to eq(user.id)
    end
  end
end