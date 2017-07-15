class Comments < ActiveRecord::Migration[5.0]
  def up
    create_table :comments do |t|
      t.string :content
      t.integer :post_id, null: false
      t.integer :user_id, null: false
      t.timestamps
   end
     add_index "comments", ["post_id"], name: "comment_post_idx", using: :btree
     add_index "comments", ["user_id"], name: "user_comment_idx", using: :btree
  end
  def down
   drop_table :comments
  end
end
