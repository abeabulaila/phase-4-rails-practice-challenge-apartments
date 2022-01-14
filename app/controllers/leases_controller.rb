class LeasesController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_response

  def create
    lease = Lease.create(rent: params[:rent], apartment: params[:apartment], tenant: params[:tenant] )
    render json: lease, status: :created
  end

  def destroy
    lease = Lease.find_by(id: params[:id])
    lease.destroy
    head :no_content
  end

  private

  def lease_params
    params.permit(:rent)
  end

  def render_unprocessable_response(e)
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end
end
