require 'rails_helper'

RSpec.describe Pizza, type: :model do
  let!(:pizza) { Pizza.create(name: "Margherita", description: "Classic margherita pizza") }
  let!(:duplicate_pizza) { Pizza.new(name: pizza.name, description: "Another pizza with duplicate name") }

  after do 
    Pizza.destroy_all
  end

  context 'validations' do
    it 'is valid with a unique name' do
      expect(pizza).to be_valid
    end

    it 'is not valid without a name' do
      pizza.name = nil
      expect(pizza).not_to be_valid
    end

    it 'is not valid with a duplicate name' do
      expect(duplicate_pizza).not_to be_valid
    end
  end

  context 'associations' do
    it 'can have many toppings' do
      topping1 = Topping.create(name: "Mushrooms")
      topping2 = Topping.create(name: "Peppers")

      pizza.toppings << [topping1, topping2]

      expect(pizza.toppings.count).to eq(2)
    end

    it 'destroys associated pizza_toppings when deleted' do
      topping = Topping.create(name: "Olives")
      pizza.toppings << topping

      expect { pizza.destroy }.to change { PizzaTopping.count }.by(-1)
    end
  end
end
