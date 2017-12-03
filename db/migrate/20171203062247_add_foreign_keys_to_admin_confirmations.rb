class AddForeignKeysToAdminConfirmations < ActiveRecord::Migration[5.1]
  def change
  	add_foreign_key :admin_confirmations, :admins, column: :admin_userid, primary_key: 'admin_userid'
  	add_foreign_key :admin_confirmations, :applications, column: :ref_no, primary_key: 'ref_no'
  end
end
