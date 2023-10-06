class AddReferenceUserToOrganization < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!
  def change
    add_reference :organizations, :user
  end
end
