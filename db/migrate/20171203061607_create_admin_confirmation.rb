class CreateAdminConfirmation < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_confirmations, id: false do |t|
      t.integer :admin_userid
      t.integer :ref_no
    end
    execute "ALTER TABLE admin_confirmations ADD PRIMARY KEY (admin_userid,ref_no);"
  end
end
