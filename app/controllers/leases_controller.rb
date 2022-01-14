class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :lease_not_found

    def create
        lease = Lease.create(lease_params)
        render json: lease, status: :created
    end

    def destroy
        find_lease.destroy
        head :no_content
    end

    private

    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end

    def find_lease
        Lease.find(params[:id])
    end

    def lease_not_found
        render json: { error: "Lease not found" }
    end
end
