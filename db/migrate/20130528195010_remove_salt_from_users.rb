class RemoveSaltFromUsers < ActiveRecord::Migration
  def change
    # Devise 1.2.1 does not require a password_salt column anymore
    remove_column :users, :password_salt
  end
end
