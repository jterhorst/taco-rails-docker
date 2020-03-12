json.extract! taco, :id, :name, :price, :description, :cheese, :lettuce, :meat, :tortilla, :beans, :created_at, :updated_at
json.url taco_url(taco, format: :json)
