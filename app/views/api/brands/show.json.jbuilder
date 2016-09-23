json.brand do
  json.id @brand.id
  json.name @brand.name
  json.first_letter @brand.first_letter
  json.factoy_ids @brand.get_factory_ids
  json.series_ids @brand.get_series_ids
end
