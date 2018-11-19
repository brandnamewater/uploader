class ChangeColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :order_status, :integer
  end
end
