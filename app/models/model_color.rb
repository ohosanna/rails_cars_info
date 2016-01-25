class ModelColor < ActiveRecord::Base
  belongs_to :model
  belongs_to :interior_color
  belongs_to :exterior_color
end
