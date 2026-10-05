class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :gift_name
      t.text :content
      t.integer :rating
      t.integer :age
      t.integer :price

      t.timestamps
    end
  end
end
