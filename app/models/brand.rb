class Brand < ActiveRecord::Base

  has_many :factories
  has_many :series, through: :factories

  default_scope { order('first_letter') }

  def get_factories_ids
    self.factories.pluck(:id)
  end
end
