class CreateHuts < ActiveRecord::Migration[6.1]
  def change
    create_table :huts do |t|
      t.string :name, null: false
      t.decimal :latitude, null: false, precision: 10, scale: 6
      t.decimal :longitude, null: false, precision: 10, scale: 6
      t.string :description, null: false
      t.timestamps
    end
  end
end
