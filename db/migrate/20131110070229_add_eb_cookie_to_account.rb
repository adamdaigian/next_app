class AddEbCookieToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :eb_cookie, :string
  end
end
