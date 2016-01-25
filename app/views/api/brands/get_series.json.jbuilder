json.array! @factories do |factory|
  json.id factory.id
  json.name factory.name
  json.series factory.series do |series|
    json.id series.id
    json.name series.name
  end
end
