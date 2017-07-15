class Posts < ActiveRecord::Migration[5.0]
  def up
    create_table :posts, id: false, force: true do |t|
     t.integer :id, null:false
     t.integer :user_id, null: false
     t.string  :title, limit: 200
     t.string :status, default: :draft
     t.timestamps
    end
    execute "ALTER TABLE posts ADD PRIMARY KEY (id);"
    add_index "posts", ["user_id"], name: "fk_ps_user_idx", using: :btree
  end
  def down
    drop_table :posts
  end
end
