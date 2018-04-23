class AddTypeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role, :string, default: "gangster", null: false
  end
end
