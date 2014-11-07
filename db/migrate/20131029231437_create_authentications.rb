class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string      :provider
      t.string      :uid
      t.string      :oauth_token
      t.string      :oauth_secret
      t.string      :refresh_token
      t.integer     :expires_at
      t.text 		:properties
      t.timestamps
    end

    add_index :authentications, :uid
  end
end
