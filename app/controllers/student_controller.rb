class StudentController < ApplicationController
def student_home
	@all_schools = School.order(:sname)
end
end