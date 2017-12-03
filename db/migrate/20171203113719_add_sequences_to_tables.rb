class AddSequencesToTables < ActiveRecord::Migration[5.1]
  def change
  	reversible do |change|
      change.up do
        execute "CREATE SEQUENCE user_seq;"
        execute "CREATE SEQUENCE school_seq;"
        execute "CREATE SEQUENCE course_seq;"
        execute "CREATE SEQUENCE application_seq;"
        execute "ALTER TABLE users ALTER COLUMN userid SET DEFAULT nextval('user_seq');"
        execute "ALTER TABLE schools ALTER COLUMN school_id SET DEFAULT nextval('school_seq');"
        execute "ALTER TABLE courses ALTER COLUMN course_id SET DEFAULT nextval('course_seq');"
        execute "ALTER TABLE applications ALTER COLUMN ref_no SET DEFAULT nextval('application_seq');"
      end
      
      change.down do
      	execute "ALTER TABLE users ALTER COLUMN userid DROP DEFAULT;"
        execute "ALTER TABLE schools ALTER COLUMN school_id DROP DEFAULT;"
        execute "ALTER TABLE courses ALTER COLUMN course_id DROP DEFAULT;"
        execute "ALTER TABLE applications ALTER COLUMN ref_no DROP DEFAULT;"
        execute "DROP SEQUENCE user_seq;"
        execute "DROP SEQUENCE school_seq;"
        execute "DROP SEQUENCE course_seq;"
        execute "DROP SEQUENCE application_seq;"
      end
    end
  end
end
