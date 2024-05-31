class CreateBookclubs < ActiveRecord::Migration[7.1]
  def change
    create_table :bookclubs do |t|
      t.string :name
      t.text :description
      t.references :organizer, null: false, foreign_key: { to_table: :users }
      t.string :location
      t.integer :max_members
      t.string :privacy
      t.string :genre
      t.date :meeting_schedule

      t.timestamps
    end
  end
end
