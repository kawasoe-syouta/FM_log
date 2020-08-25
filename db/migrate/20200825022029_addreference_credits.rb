class AddreferenceCredits < ActiveRecord::Migration[6.0]
  def change
    add_reference :credits, :user, foreign_key: true
    change_column_null :credits, :user_id, false
  end
end
