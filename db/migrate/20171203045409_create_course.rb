class CreateCourse < ActiveRecord::Migration[5.1]
  def change
    create_table :courses, id: false do |t|
      t.integer :course_id, primary_key: true
      t.string :course_name
      t.integer :duration
      t.string :sector
      t.float :tuition_fee
    end
  end
end
