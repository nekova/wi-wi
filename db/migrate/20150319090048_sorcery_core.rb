class SorceryCore < ActiveRecord::Migration
  def change
    add_column :users, :email, :string, :null => false
    add_column :users, :crypted_password, :string
    add_column :users, :salt, :string

    add_index :users, :email, unique: true
  end
end
