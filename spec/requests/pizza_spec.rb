require 'rails_helper'

RSpec.describe PizzasController, type: :request do
  let!(:pizza) { Pizza.create(name: "Pepperoni Pizza", description: "Delicious pepperoni pizza") }
  let(:valid_attributes) { { name: "New Pizza", description: "Cheesy and delicious" } }
  let(:invalid_attributes) { { name: "", description: "No name provided" } }

  after do 
    Pizza.destroy_all
  end
  
  describe 'GET #index' do
    it 'returns a successful response' do
      get pizzas_path
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      get pizzas_path
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get pizza_path(pizza)
      expect(response).to have_http_status(:ok)
    end

    it 'renders the show template' do
      get pizza_path(pizza)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get new_pizza_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new pizza' do
        expect {
          post pizzas_path, params: { pizza: valid_attributes }
        }.to change(Pizza, :count).by(1)
      end

      it 'redirects to the created pizza' do
        post pizzas_path, params: { pizza: valid_attributes }
        expect(response).to redirect_to(Pizza.last)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new pizza' do
        expect {
          post pizzas_path, params: { pizza: invalid_attributes }
        }.not_to change(Pizza, :count)
      end

      it 'renders the new template again' do
        post pizzas_path, params: { pizza: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    let(:new_attributes) { { name: "Updated Pizza", description: "Updated description" } }

    it 'updates the requested pizza' do
      put pizza_path(pizza), params: { pizza: new_attributes }
      pizza.reload
      expect(pizza.name).to eq("Updated Pizza")
    end

    it 'redirects to the pizza' do
      put pizza_path(pizza), params: { pizza: new_attributes }
      expect(response).to redirect_to(pizza)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested pizza' do
      expect {
        delete pizza_path(pizza)
      }.to change(Pizza, :count).by(-1)
    end

    it 'redirects to the pizzas list' do
      delete pizza_path(pizza)
      expect(response).to redirect_to(pizzas_path)
    end
  end
end
