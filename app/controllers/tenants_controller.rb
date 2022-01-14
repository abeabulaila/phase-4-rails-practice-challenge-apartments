class TenantsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def index
    render json: Tenant.all
  end

  def show
    tenant = find_tenant
    render json: tenant
  end

  def create
    tenant = Tenant.create!(tenant_params)
    render json: tenant, status: :created
  end

  def update
    tenant = find_tenant
    if tenant
      tenant.update(tenant_params) 
      render json: tenant, status: :ok
    else
        render_not_found
    end
  end

  def destroy
    tenant = find_tenant
    tenant.destroy
    head :no_content
  end

  private

  def find_tenant
    Tenant.find_by(id: params[:id])
  end

  def tenant_params
    params.permit(:name, :age)
  end

  def render_unprocessable_response(e)
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def render_not_found
    render json: { error: "Tenant not found" }, status: :not_found
  end
end
