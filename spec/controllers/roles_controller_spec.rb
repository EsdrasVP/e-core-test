require 'rails_helper'

RSpec.describe RolesController, type: :controller do
  let(:valid_attributes) { { name: 'New Role' } }
  let(:invalid_attributes) { { name: nil } }

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Role' do
        expect {
          post :create, params: { role: valid_attributes }
        }.to change(Role, :count).by(1)
      end

      it 'renders a JSON response with the new role' do
        post :create, params: { role: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to include('application/json')
        expect(JSON.parse(response.body)['name']).to eq('New Role')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Role' do
        expect {
          post :create, params: { role: invalid_attributes }
        }.to change(Role, :count).by(0)
      end

      it 'renders a JSON response with errors for the new role' do
        post :create, params: { role: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
        expect(JSON.parse(response.body)['name']).to include("can't be blank")
      end
    end
  end

  describe 'GET #index' do
    let!(:role) { Role.create(name: 'Admin') }

    it 'renders a JSON response with a list of roles' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(JSON.parse(response.body).first['id']).to eq(role.id)
    end
  end
end
