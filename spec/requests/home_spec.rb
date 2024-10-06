require 'rails_helper'

RSpec.describe HomeController, type: :request do
  describe 'GET #index' do
    it 'returns a successful response' do
      get root_path
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      get root_path
      expect(response).to render_template(:index)
    end

    it 'displays the correct text on the home page' do
      get root_path
      expect(response.body).to include("Welcome to the Pizza Manager")
    end
  end
end
