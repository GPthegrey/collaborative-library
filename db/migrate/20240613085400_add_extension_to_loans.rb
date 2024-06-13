class AddExtensionToLoans < ActiveRecord::Migration[7.1]
  def change
    add_column :loans, :extension, :string
  end
end
