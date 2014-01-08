class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :integer
    add_column :users, :oauth_expires_at, :datetime
    add_column :users, :oauth_token, :string
    add_column :users, :provider, :string

    remove_column :users, :password, :string
    remove_column :users, :password_confirmation, :string
    remove_column :users, :password_digest, :string
    remove_column :users, :remember_token, :string
    remove_column :users, :zipcode, :integer
  end
end
