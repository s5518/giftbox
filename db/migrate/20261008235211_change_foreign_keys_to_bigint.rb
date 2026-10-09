class ChangeForeignKeysToBigint < ActiveRecord::Migration[8.1]
  def change
    change_column :bookmarks, :user_id, :bigint
    change_column :bookmarks, :post_id, :bigint

    change_column :comments, :user_id, :bigint
    change_column :comments, :post_id, :bigint

    change_column :post_tags, :post_id, :bigint
    change_column :post_tags, :tag_id, :bigint

    change_column :posts, :user_id, :bigint
  end
end
