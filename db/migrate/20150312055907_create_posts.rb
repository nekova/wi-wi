class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true
      t.string :title
      t.string :url
      t.text :content, null: false

      t.timestamps null: false
    end
    add_foreign_key :posts, :users
  end
end
