class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :user_reviewed, null: false, foreign_key: { to_table: :users }
      t.references :user_reviewer, null: false, foreign_key: { to_table: :users }
      t.references :loan, null: false, foreign_key: true
      t.integer :rating
      t.text :comment

      t.timestamps
    end
  end
end
