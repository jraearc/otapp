class CreateStudent < ActiveRecord::Migration[5.1]
  def change
    create_table :students, id: false do |t|
      t.integer :student_userid, primary_key: true
      t.date :birthdate
      t.string :address
      t.string :civil_status
    end
  end
end
