class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.integer :review_id, null: false
      t.string :body, null: false
      t.timestamps
    end

    add_foreign_key :comments, :users, column: :user_id
    add_foreign_key :comments, :reviews, column: :review_id
  end
end
