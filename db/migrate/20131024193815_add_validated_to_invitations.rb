class AddValidatedToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :validated_at, :timestamp
  end
end
