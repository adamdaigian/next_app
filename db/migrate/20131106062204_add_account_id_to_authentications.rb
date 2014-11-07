class AddAccountIdToAuthentications < ActiveRecord::Migration
  def change
    add_reference :authentications, :account
  end
end
