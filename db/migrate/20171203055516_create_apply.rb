class CreateApply < ActiveRecord::Migration[5.1]
  def change
    create_table :applies, id: false do |t|
      t.integer :student_userid
      t.integer :school_id
      t.integer :ref_no
      t.string :is_received
    end
    execute "ALTER TABLE applies ADD PRIMARY KEY (student_userid,school_id,ref_no);"
  end
end
