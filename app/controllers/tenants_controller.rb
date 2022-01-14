class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :tenant_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_data

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def index
        render json: Tenant.all
    end

    def show
        render json: find_tenant
    end

    def update
        find_tenant.update!(tenant_params)
        render json: find_tenant
    end

    def destroy
        find_tenant.destroy
        head :no_content
    end

    private

    def tenant_params
        params.permit(:name, :age)
    end

    def find_tenant
        Tenant.find(params[:id])
    end

    def tenant_not_found
        render json: { error: "Tenant not found" }, status: :not_found
    end

    def unprocessable_entity_data(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
end
