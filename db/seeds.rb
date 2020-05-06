# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
# ActiveRecord::Base.connection.tables.each do |t|
#   ActiveRecord::Base.connection.reset_sequence!(t)
# end

Taco.delete_all

25.times do
  name = Faker::Food.dish
  description = Faker::Food.description
  price = Faker::Number.decimal(l_digits: 1, r_digits: 2)
  meat = Faker::Boolean.boolean ? "beef" : "chicken"
  Taco.create(name: name, price: price, description: description, cheese: Faker::Boolean.boolean, lettuce: Faker::Boolean.boolean, meat: meat, tortilla: Faker::Boolean.boolean, beans: Faker::Boolean.boolean)
end

# Delayed::Job.enqueue(TacoSpecialJob.new,cron: '* */5 * * *')
