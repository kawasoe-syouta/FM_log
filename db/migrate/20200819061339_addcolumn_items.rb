class AddcolumnItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :delivery_area_id, :integer
    rename_column :items, :delivery_days, :delivery_day_id
    add_referneces :items, :delivery_day_id, foreign_key: true
  end
end
