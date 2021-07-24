class RenameColumnName < ActiveRecord::Migration[6.1]
  def change
    remove_column :invitations, :accepted
    add_column :invitations, :status, :integer, default: 0
  end
end
