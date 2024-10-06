class ToppingsController < ApplicationController
  before_action :set_topping, only: %i[ show edit update destroy ]

  # GET /toppings or /toppings.json
  def index
    @toppings = Topping.all
  end

  # GET /toppings/1 or /toppings/1.json
  def show
  end

  # GET /toppings/new
  def new
    @topping = Topping.new
  end

  # GET /toppings/1/edit
  def edit
  end

  # POST /toppings or /toppings.json
  def create
    @topping = Topping.new(topping_params)

    respond_to do |format|
      if @topping.save
        format.html { redirect_to @topping, notice: "Topping was colldasfas created." }
        format.json { render :show, status: :created, location: @topping }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @topping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /toppings/1 or /toppings/1.json
  def update
    respond_to do |format|
      if @topping.update(topping_params)
        format.html { redirect_to @topping, notice: "Topping was successfully updated." }
        format.json { render :show, status: :ok, location: @topping }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @topping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /toppings/1 or /toppings/1.json
  def destroy
    respond_to do |format|
      @topping.destroy
        format.html { redirect_to toppings_path, notice: 'Topping was successfully deleted.' }
        format.json { head :no_content }
      rescue ActiveRecord::InvalidForeignKey
        if @topping.pizzas.any?
          format.html { redirect_to @topping, alert: 'Cannot delete topping because it is used on one or more pizzas.' }
          format.json { head :no_content }       
        else
          raise 
        end
    end
  end

  private
    def set_topping
      @topping = Topping.find(params[:id])
    end

    def topping_params
      params.require(:topping).permit(:name)
    end
end
