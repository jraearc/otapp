class LandingController < ApplicationController

def index
	@all_schools = School.order(:sname)
end
end