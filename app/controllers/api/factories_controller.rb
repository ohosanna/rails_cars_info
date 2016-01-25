class Api::FactoriesController  < Api::BaseController
  respond_to :json
  def show
    @factory = Factory.find(params[:id])
  end
end
