class CreateStreets < ActiveRecord::Migration[6.0]
  def change
    create_table :streets do |t|
      t.integer :user_id,            null: false, foreign_key: true
      t.string :prefecture_id,       null:false, foreign_key: true
      t.string :postal_code,         null: false, limit: 7
      t.string :city,                null: false
      t.string :address,             null: false
      t.string :building_name
      t.string :phone_number,        null: false, limit: 12
      
      t.timestamps
    end
  end
end
