class CreateLoans < ActiveRecord::Migration[7.1]
  def change
    create_table :loans do |t|
      t.references :book, null: false, foreign_key: true
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.references :borrower, null: false, foreign_key: { to_table: :users }
      t.string :status

      t.timestamps
    end
  end
end
