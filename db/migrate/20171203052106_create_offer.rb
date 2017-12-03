class CreateOffer < ActiveRecord::Migration[5.1]
  def change
    create_table :offers, id: false do |t|
      t.integer :school_id
      t.integer :course_offered_id
    end
    execute "ALTER TABLE offers ADD PRIMARY KEY (school_id,course_offered_id);"
  end
end
