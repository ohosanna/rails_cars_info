class Api::BrandsController < Api::BaseController
  respond_to :json
  def index
    @brands = Brand.all
  end

  def show
    @brand = Brand.find(params[:id])
    @factories = @brand.factories
  end

  def get_series
    @brand = Brand.find(params[:id])
    @factories = @brand.factories
    @series = @brand.series
  end
end
