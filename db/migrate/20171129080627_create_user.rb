class CreateUser < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: false do |t|
      t.integer :userid, primary_key: true
      t.string :username
      t.string :e_mail
      t.string :name
      t.string :password
    end
  end
end
