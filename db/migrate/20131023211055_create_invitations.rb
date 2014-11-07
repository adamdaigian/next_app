class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :name
      t.string :email
      t.string :company
      t.string :promocode
      t.string :token

      t.timestamps
    end
  end
end
