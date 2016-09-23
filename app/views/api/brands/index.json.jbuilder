json.brands @brands do |brand|
  json.id brand.id
  json.name brand.name
  json.first_letter brand.first_letter
  json.factory_ids brand.get_factory_ids
end
