class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :from_location
      t.integer :to_location
      t.text :details

      t.timestamps null: false
    end
  end
end
