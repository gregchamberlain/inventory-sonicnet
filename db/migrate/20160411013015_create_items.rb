class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :make
      t.string :model
      t.text :details
      t.string :nickname
      t.decimal :unit_price

      t.timestamps null: false
    end
  end
end
