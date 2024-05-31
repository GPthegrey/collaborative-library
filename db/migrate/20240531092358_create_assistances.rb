class CreateAssistances < ActiveRecord::Migration[7.1]
  def change
    create_table :assistances do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
