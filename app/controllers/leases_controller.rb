class LeasesController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_response

  def create
    lease = Lease.create!(lease_params)
    render json: lease, status: :created
  end

  def destroy
  end

  private

  def lease_params
    params.permit(:rent)
  end

  def render_unprocessable_response(e)
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end
end
