class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.integer :user_id, index: true

      t.timestamps null: false
    end
  end
end
