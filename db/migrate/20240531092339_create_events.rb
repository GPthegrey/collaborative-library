class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :address
      t.references :organizer, null: false, foreign_key: { to_table: :users }
      t.integer :max_assistants
      t.string :privacy

      t.timestamps
    end
  end
end
