class Series < ActiveRecord::Base

  has_many :models
  belongs_to :factory

  def get_models_ids
    self.models.pluck(:id)
  end
end
