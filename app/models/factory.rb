class Factory < ActiveRecord::Base

  has_many :series
  belongs_to :brand

  def get_series_ids
    self.series.pluck(:id)
  end

end
