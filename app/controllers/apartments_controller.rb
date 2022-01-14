class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :apartment_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_data


    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    end

    def index
        render json: Apartment.all
    end

    def show
        render json: find_apartment
    end

    def update
        find_apartment.update!(apartment_params)
        render json: find_apartment
    end

    def destroy
        find_apartment.destroy
        head :no_content
    end

    private

    def apartment_params
        params.permit(:number)
    end

    def find_apartment
        Apartment.find(params[:id])
    end

    def apartment_not_found
        render json: { error: "Apartment not found" }, status: :not_found
    end

    def unprocessable_entity_data(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end

end
