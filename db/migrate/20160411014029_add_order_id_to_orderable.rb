class AddOrderIdToOrderable < ActiveRecord::Migration
  def change
    add_column :orderables, :order_id, :integer
  end
end
