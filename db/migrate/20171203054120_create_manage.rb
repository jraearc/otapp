class CreateManage < ActiveRecord::Migration[5.1]
  def change
    create_table :manages, id: false do |t|
      t.integer :admin_userid, primary_key: true
      t.integer :school_id
    end
  end
end
