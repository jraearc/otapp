class AddForeignKeysToAdmins < ActiveRecord::Migration[5.1]
  def change
  	add_foreign_key :admins, :users, column: :admin_userid, primary_key: 'userid', on_delete: :cascade
  end
end
