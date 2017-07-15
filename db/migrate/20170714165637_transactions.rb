class Transactions < ActiveRecord::Migration[5.0]
  def up
   create_table :transactions do |t|
    t.datetime :sold_at
   end
  end
  def down
   drop_tables :transations
  end
end
