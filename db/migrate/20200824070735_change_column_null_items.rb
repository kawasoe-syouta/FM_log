class ChangeColumnNullItems < ActiveRecord::Migration[6.0]
  def change
    change_column_null :items, :sell_user_id, false
    change_column_null :items, :delivery_day_id, false
  end
end
