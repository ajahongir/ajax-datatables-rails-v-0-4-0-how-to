class CitiesController < ApplicationController
  respond_to :html, :json

  def index
    respond_to do |format|
      format.html
      format.json do
        render json: CityDatatable.new(view_context)
      end
    end
  end
end