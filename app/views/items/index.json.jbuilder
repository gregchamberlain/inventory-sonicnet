json.array!(@items) do |item|
  json.extract! item, :id, :make, :model, :details, :nickname, :unit_price
  json.url item_url(item, format: :json)
end
