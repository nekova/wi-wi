class AddCachedVotesToComments < ActiveRecord::Migration
  def change
    add_column :comments, :cached_votes_score, :integer, default: 0
    add_index :comments, :cached_votes_score
  end
end
