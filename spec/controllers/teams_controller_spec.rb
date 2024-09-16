require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  let!(:team) { Team.create(external_id: '1e6da77f-dc6f-4994-b399-47626db9cd28', name: 'Development Team') }

  describe 'GET #import' do
    before do
      allow_any_instance_of(TeamFetcher).to receive(:call).and_return([ team ])
    end

    it 'renders a JSON response with the new team' do
      get :import
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(JSON.parse(response.body).first['external_id']).to eq(team.external_id)
    end
  end

  describe 'GET #index' do
    it 'renders a JSON response with a list of teams' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(JSON.parse(response.body).first['id']).to eq(team.id)
    end
  end

  describe 'GET #show' do
    it 'renders a JSON response with a team' do
      get :show, params: { id: team.id }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(JSON.parse(response.body)['id']).to eq(team.id)
    end
  end
end
