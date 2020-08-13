class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
<<<<<<< HEAD
=======

>>>>>>> 54b1955... カテゴリーupdate
      t.timestamps
    end
  end
end
