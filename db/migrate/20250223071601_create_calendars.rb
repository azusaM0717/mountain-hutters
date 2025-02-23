class CreateCalendars < ActiveRecord::Migration[6.1]
  def change
    create_table :calendars do |t|
      t.references :user, null: false, foreign_key: true
      t.references :hut, null: false, foreign_key: true
      t.string :title
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
