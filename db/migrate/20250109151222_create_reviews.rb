class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :user_id, null: false
      t.integer :hut_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.integer :rating, null: false
      t.timestamps
    end

    add_index :reviews, :hut_id
    add_index :reviews, :rating

    add_foreign_key :reviews, :users, column: :user_id
    add_foreign_key :reviews, :huts, column: :hut_id
  end
end
