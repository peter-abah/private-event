class AddFieldToInvitation < ActiveRecord::Migration[6.1]
  def change
    add_column :invitations, :accepted, :boolean
  end
end
