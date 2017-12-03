class AddForeignKeyToStudents < ActiveRecord::Migration[5.1]
  def change
  	add_foreign_key :students, :users, column: :student_userid, primary_key: 'userid', on_delete: :cascade
  end
end
