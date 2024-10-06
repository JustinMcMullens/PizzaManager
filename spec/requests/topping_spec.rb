require 'rails_helper'

RSpec.describe ToppingsController, type: :request do
  let!(:topping) { Topping.create(name: "Cheese") }
  let(:valid_attributes) { { name: "Pepperoni" } }
  let(:invalid_attributes) { { name: "" } }

  after do 
    Topping.destroy_all
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get toppings_path
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      get toppings_path
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get topping_path(topping)
      expect(response).to have_http_status(:ok)
    end

    it 'renders the show template' do
      get topping_path(topping)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get new_topping_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new topping' do
        expect {
          post toppings_path, params: { topping: valid_attributes }
        }.to change(Topping, :count).by(1)
      end

      it 'redirects to the created topping' do
        post toppings_path, params: { topping: valid_attributes }
        expect(response).to redirect_to(Topping.last)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new topping' do
        expect {
          post toppings_path, params: { topping: invalid_attributes }
        }.not_to change(Topping, :count)
      end

      it 'renders the new template again' do
        post toppings_path, params: { topping: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    let(:new_attributes) { { name: "Updated Topping" } }

    it 'updates the requested topping' do
      put topping_path(topping), params: { topping: new_attributes }
      topping.reload
      expect(topping.name).to eq("Updated Topping")
    end

    it 'redirects to the topping' do
      put topping_path(topping), params: { topping: new_attributes }
      expect(response).to redirect_to(topping)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested topping' do
      expect {
        delete topping_path(topping)
      }.to change(Topping, :count).by(-1)
    end

    it 'redirects to the toppings list' do
      delete topping_path(topping)
      expect(response).to redirect_to(toppings_path)
    end
  end
end

