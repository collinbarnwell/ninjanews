class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :integer
    add_column :users, :oauth_expires_at, :datetime
    add_column :users, :oauth_token, :string
    add_column :users, :provider, :string
  end
end
