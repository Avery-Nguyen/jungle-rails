class AddLastNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_name, :string
    remove_column :users, :name, :string
  end
end
