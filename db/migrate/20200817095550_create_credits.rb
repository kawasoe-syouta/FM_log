class CreateCredits < ActiveRecord::Migration[6.0]
  def change
    create_table :credits do |t|
      # t.references :user, null: false, foreign_key: true
      t.string :card_customer, null: false
      t.string :card_default

      t.timestamps
    end
  end
end
