class AddForeignKeyToApplications < ActiveRecord::Migration[5.1]
  def change
  	add_foreign_key :applications, :courses, column: :course_id, primary_key: 'course_id'
  end
end
