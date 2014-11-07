class AddAuthenticationIdToInvitations < ActiveRecord::Migration
  def change
    add_reference :invitations, :authentication
  end
end
