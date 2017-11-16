class GradesController < ApplicationController
	before_action :set_grade, only: [:show,:edit,:update,:destroy]
	
	def index
		@grades = Grade.all
	end

	def new 
		@grade = Grade.new 

		render :new
	end 

	def create 
		@grade = Grade.new(grade_params)
		
		if @grade.save
			redirect_to grades_path
		else
			render :new
		end
	end 

	def update
		if @grade.update(grade_params)
			redirect_to grades_path
		else
			render :edit
		end
	end

	def destroy 
		@grade.destroy
		redirect_to grades_path
	end

	def edit 
	end
		# get /grade/1 
	def show
	end

	private
	def grade_params
		params.require(:grade).permit(:name) 
	end
	#take a id of grade
	def set_grade
		@grade = Grade.find(params[:id])

	end


end
