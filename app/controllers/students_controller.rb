class StudentsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_grade_options, only: [:new, :show,:index,:update,:create,:edit]
	before_action :set_student, only: [:show,:edit,:update,:destroy]

	def new
		@student = Student.new

		render :new
	end

	def index
		@students =	Student.includes(:grade).all.page(params[:page]).per(10)
	end

	def create
		@student = Student.new(student_params)

		if @student.save
			redirect_to students_path
		else
			render :new
		end
	end

	def show
	end

	def edit
	end

	def update
		if @student.update(student_params)
			redirect_to students_path
		else
			render :edit
		end

	end

	def destroy
		@student.destroy
		redirect_to students_path
	end

	private
	def student_params
		params.require(:student).permit(:name, :grade_id, :gender)

	end

	def set_grade_options
		@grade_options = Grade.all.map{|g| [g.name, g.id]}
	end

	def set_student
		@student = Student.find(params[:id])
	end
end