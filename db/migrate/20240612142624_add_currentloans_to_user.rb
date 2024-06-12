class AddCurrentloansToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :Currentloans, :integer, default: 0
  end
end
