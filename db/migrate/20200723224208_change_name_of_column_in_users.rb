class ChangeNameOfColumnInUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    remove_column :users, :full_name, :string
  end
end
