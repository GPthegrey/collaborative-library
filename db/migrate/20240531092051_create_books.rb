class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.references :user, null: false, foreign_key: true
      t.text :description
      t.string :genre
      t.integer :rating
      t.string :language

      t.timestamps
    end
  end
end
