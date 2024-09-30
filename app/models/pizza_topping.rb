class PizzaTopping < ApplicationRecord
  belongs_to :pizza
  belongs_to :topping
  delegate :name, to: :topping
end
