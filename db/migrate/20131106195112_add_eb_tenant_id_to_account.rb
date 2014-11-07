class AddEbTenantIdToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :eb_tenant_id, :string
  end
end
