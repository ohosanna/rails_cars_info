class Api::SeriesController < ApplicationController
  respond_to :json
  def show
    @series = Series.find(params[:id])
  end
end
