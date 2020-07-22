class AddFullNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :full_name, :string
    add_column :users, :last_name, :string
    remove_column :users, :name, :string
  end
end
