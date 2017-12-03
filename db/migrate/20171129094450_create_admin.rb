class CreateAdmin < ActiveRecord::Migration[5.1]
  def change
    create_table :admins, id: false do |t|
      t.integer :admin_userid, primary_key: true
      t.string :school_pos
    end
  end
end
