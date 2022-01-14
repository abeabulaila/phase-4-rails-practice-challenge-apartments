class ApartmentsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def index #GET
    apartment = Apartment.all
    render json: apartment
  end

  def show #GET
    apartment = find_apartment
    render json: apartment
  end

  def create #POST
    apartment = Apartment.create!(apartment_params)
    render json: apartment, status: :created
  end

  def update #PATCH
    apartment = find_apartment
    if apartment 
    apartment.update(apartment_params)
    render json: apartment, status: :ok
    else
        render_not_found 
    end
  end

  def destroy #KILL
    apartment = find_apartment
    apartment.destroy
    head :no_content
  end

  private

  def apartment_params
    params.permit(:number)
  end

  def render_unprocessable_response(e)
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def render_not_found
    render json: { error: "Apartment not found" }, status: :not_found
  end

  def find_apartment
    Apartment.find_by(id: params[:id])
  end
end
