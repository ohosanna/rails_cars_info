class Model < ActiveRecord::Base
  belongs_to :series
  has_one :ac, autosave: true
  has_one :base_spec, autosave: true
  has_one :brake, autosave: true
  has_one :console, autosave: true
  has_one :engine, autosave: true
  has_one :exterior, autosave: true
  has_one :h_tech_spec, autosave: true
  has_one :interior, autosave: true
  has_one :lamp, autosave: true
  has_one :mirror, autosave: true
  has_one :multimedium, autosave: true
  has_one :safety, autosave: true
  has_one :seat, autosave: true
  has_one :steering, autosave: true
  has_one :transmission, autosave: true
  has_one :vehicle_body, autosave: true
  has_many :model_colors
  has_many :interior_colors, :through => :model_colors
  has_many :exterior_colors, :through => :model_colors

  def search_from_vin(series_id, year, structure, displacement, gearbox)
    return Model.where("series_id = :series_id AND produce_year = :produce_year AND structure = :structure AND displacement = :displacement, gearbox_name = :gearbox", {series_id: series_id, produce_year: year, structure: structure, displacement: displacement, gearbox: gearbox})
  end
end
