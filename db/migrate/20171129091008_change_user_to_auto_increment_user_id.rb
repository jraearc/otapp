class ChangeUserToAutoIncrementUserId < ActiveRecord::Migration[5.1]
  def change
  	change_column :users, :userid, :int, auto_increment: true
  end
end
