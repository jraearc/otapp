class StudentController < ApplicationController
def student_home
	@all_schools = School.order(:sname)
end
def student_profile
	@apps = Apply.joins('join applications on applies.ref_no = applications.ref_no join courses on courses.course_id = applications.course_id join schools on applies.school_id = schools.school_id').select('applies.student_userid, schools.school_id, schools.sname, applies.is_received, courses.course_name')
	#need pa ng "where" clause kasi lahat lang ng inaapplyan ng student yung lalabas
end
end