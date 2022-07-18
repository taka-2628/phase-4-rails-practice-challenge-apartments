class LeasesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def create
    lease = Lease.create(lease_params)
    render json: lease, status: :created
    
  end

  def destroy
    lease = Lease.find(params[:id])
    lease.destroy
    head :no_content, status: :deleted
  end

  private 
  
  def lease_params
    params.permit(:id, :rent, :apartment_id, :tenant_id)
  end

  def render_not_found_response
    render json: { error: "Lease not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end
  
end
