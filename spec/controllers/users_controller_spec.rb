require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { User.create(external_id: '0e378b61-9cca-478b-97d2-a055792e596b', display_name: 'John Doe') }

  describe 'GET #import' do
    before do
      allow_any_instance_of(UserFetcher).to receive(:call).and_return([ user ])
    end

    it 'renders a JSON response with the new user' do
      get :import
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(JSON.parse(response.body).first['external_id']).to eq(user.external_id)
    end
  end

  describe 'GET #index' do
    it 'renders a JSON response with a list of users' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(JSON.parse(response.body).first['id']).to eq(user.id)
    end
  end

  describe 'GET #show' do
    it 'renders a JSON response with a user' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(JSON.parse(response.body)['id']).to eq(user.id)
    end
  end
end
