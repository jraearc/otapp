class AddForeignKeysToOffers < ActiveRecord::Migration[5.1]
  def change
  	add_foreign_key :offers, :schools, column: :school_id, primary_key: 'school_id'
  	add_foreign_key :offers, :courses, column: :course_offered_id, primary_key: 'course_id', on_update: :cascade, on_delete: :cascade
  end
end
