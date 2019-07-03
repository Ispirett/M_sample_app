class RenamePasswwordResetColumnOnUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users , :password_reset , :reset_digest
  end
end
