class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :email
      t.string :company
      t.string :token
      t.string :eb_tenant_name
      t.string :encrypted_password, null: false, default: ""

      t.timestamps
    end
  end
end
