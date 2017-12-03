class AddForeignKeysToManages < ActiveRecord::Migration[5.1]
  def change
  	add_foreign_key :manages, :admins, column: :admin_userid, primary_key: 'admin_userid'
  	add_foreign_key :manages, :schools, column: :school_id, primary_key: 'school_id'
  end
end
