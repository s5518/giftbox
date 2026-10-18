class ChangeRatingToFloatInPosts < ActiveRecord::Migration[8.1]
  def change
    change_column :posts, :rating, :float
  end
end
