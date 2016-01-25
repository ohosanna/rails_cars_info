json.factory do
  json.id @factory.id
  json.name @factory.name
  json.series_ids @factory.get_series_ids
end
