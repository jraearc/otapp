class CreateSchool < ActiveRecord::Migration[5.1]
  def change
    create_table :schools, id: false do |t|
      t.integer :school_id, primary_key: true
      t.string :sname
      t.string :phone
      t.string :address
      t.string :email
    end
  end
end
