class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :reputation, :integer, default: 0
    add_index :users, :reputation
  end
end
