class CreateApplication < ActiveRecord::Migration[5.1]
  def change
    create_table :applications, id: false do |t|
      t.integer :ref_no, primary_key: true
      t.integer :course_id
    end
  end
end
