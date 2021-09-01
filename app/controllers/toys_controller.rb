class ToysController < ApplicationController
  wrap_parameters format: []
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response


  def index
    toys = Toy.all
    render json: toys
  end

  def create
    toy = Toy.create!(toy_params)
    render json: toy, status: :created
  end

  def update
    toy = find_toy
    toy.update(toy_params)
    render json: toy, status: 202
    # if toy
    #   toy.update(toy_params)
    #   render json: toy, status: 202
    # else
    #   render json: { error: "Toy not found" }, status: :not_found
    # end
  
  end

  def destroy
    toy = find_toy
    toy.destroy
    head :no_content
  end

  private

  def find_toy
    Toy.find(params[:id])
  end
  
  def toy_params
    params.permit(:name, :image, :likes)
  end

  def render_not_found_response
    render json: { error: "Toy not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages  }, status: :unprocessable_entity
  end


end
