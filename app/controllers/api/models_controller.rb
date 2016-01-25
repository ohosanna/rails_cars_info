class Api::ModelsController < ApplicationController
  respond_to :json
  def show
    @model = Model.find(params[:id])
  end
end
