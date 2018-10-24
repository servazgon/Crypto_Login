class ChangeColumnsInAdminUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :admin_users, :provider, :string
    add_column :admin_users, :uid,      :string

    add_index :admin_users, [:provider, :uid], unique: true

    
  end
end
