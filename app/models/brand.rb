class Brand < ActiveRecord::Base

  has_many :factories
  has_many :series, through: :factories

  default_scope { order('first_letter') }

  def get_factory_ids
    self.factories.pluck(:id)
  end
  def get_series_ids
    self.series.pluck(:id)
  end
end
