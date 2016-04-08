json.array!(@locations) do |location|
  json.extract! location, :id, :name, :details, :category
  json.url location_url(location, format: :json)
end
