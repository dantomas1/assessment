class Users < ActiveRecord::Migration[5.0]
  def up
   create_table :users, id: false, force: true do |t|
     t.integer :id, null: false
     t.string :username, null: false
     t.string :email, null: false
   end
     execute "ALTER TABLE users ADD PRIMARY KEY (id);"
  end
 def down
   drop_table :users
 end
end
