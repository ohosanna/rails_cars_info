json.series do
  json.id @series.id
  json.name @series.name
  json.model_ids @series.get_models_ids
end
