class Topping < ApplicationRecord
    has_many :pizza_toppings
    has_many :pizzas, through: :pizza_toppings
    validates :name, presence: true, uniqueness: true
end
