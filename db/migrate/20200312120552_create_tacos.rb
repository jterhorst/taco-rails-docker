class CreateTacos < ActiveRecord::Migration[6.0]
  def change
    create_table :tacos do |t|
      t.string :name
      t.decimal :price, precision: 7, scale: 2
      t.text :description
      t.boolean :cheese
      t.boolean :lettuce
      t.string :meat
      t.boolean :tortilla
      t.boolean :beans

      t.timestamps
    end
  end
end
