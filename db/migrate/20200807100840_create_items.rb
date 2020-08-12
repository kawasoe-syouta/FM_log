class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :sell_user, null: false, foreign_key: {to_table: :users}
      t.references :buy_user, null: false, foreign_key: {to_table: :users}
      t.references :category, null: false, foreign_key: true
      t.integer :phase_id, null: false, foreign_key: true
      t.integer :status_id, null: false, foreign_key: true
      t.integer :delivery_to_pay_id, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :price, null: false
      t.text :item_detail
      t.integer :delivery_days, null: false

      t.timestamps
    end
  end
end
