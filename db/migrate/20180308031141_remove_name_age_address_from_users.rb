class RemoveNameAgeAddressFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :age, :integer
    remove_column :users, :name, :string
    remove_column :users, :address, :string
  end
end
