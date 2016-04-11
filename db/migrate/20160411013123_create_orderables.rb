class CreateOrderables < ActiveRecord::Migration
  def change
    create_table :orderables do |t|
      t.integer :item_id
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
