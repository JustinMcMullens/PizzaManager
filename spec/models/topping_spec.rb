require 'rails_helper'

RSpec.describe Topping, type: :model do
  let(:topping) { Topping.new(name: "Cheese") }

  after do 
    Topping.destroy_all
  end

  context 'validations' do
    it 'is valid with a name' do
      expect(topping).to be_valid
    end

    it 'is not valid without a name' do
      topping.name = nil
      expect(topping).not_to be_valid
    end

    it 'is not valid with a duplicate name' do
      Topping.create!(name: "Cheese")
      expect(topping).not_to be_valid
    end
  end

  context 'associations' do
    it 'can have many pizzas' do
      pizza1 = Pizza.create!(name: "Pepperoni Pizza", description: "Delicious pepperoni pizza")
      pizza2 = Pizza.create!(name: "Veggie Pizza", description: "A pizza with lots of veggies")

      topping.pizzas << [pizza1, pizza2]
      topping.save!

      expect(topping.pizzas.count).to eq(2)
    end

    it 'destroys associated pizza_toppings when deleted' do
      pizza = Pizza.create!(name: "Cheese Pizza", description: "Plain cheese pizza")
      topping.pizzas << pizza
      topping.save!

      expect(topping.pizzas.count).to eq(1)

      expect { topping.destroy }.to change { PizzaTopping.count }.by(-1)
    end
  end
end
