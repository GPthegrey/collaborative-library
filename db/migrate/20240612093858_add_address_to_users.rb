class AddAddressToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :address, :string
    add_column :users, :nickname, :string
    add_column :users, :admin, :boolean, default: false
  end
end
