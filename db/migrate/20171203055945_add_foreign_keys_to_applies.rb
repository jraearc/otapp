class AddForeignKeysToApplies < ActiveRecord::Migration[5.1]
  def change
  	add_foreign_key :applies, :students, column: :student_userid, primary_key: 'student_userid'
  	add_foreign_key :applies, :schools, column: :school_id, primary_key: 'school_id'
  	add_foreign_key :applies, :applications, column: :ref_no, primary_key: 'ref_no'
  end
end
