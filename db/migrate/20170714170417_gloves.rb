class Gloves < ActiveRecord::Migration[5.0]
  def up
   create_table :gloves do |t|
    t.integer :transaction_id
    t.string  :glove_type
   end
  end
  def down
   drop_table :gloves
  end
end
