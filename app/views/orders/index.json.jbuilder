json.array!(@orders) do |order|
  json.extract! order, :id, :from_location, :to_location, :details
  json.url order_url(order, format: :json)
end
