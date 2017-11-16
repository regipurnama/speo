class TeachersController < ApplicationController 
	before_action :set_teacher, only: [:show,:edit,:update,:destroy]

	def new
		@teacher = Teacher.new 

		render :new
	end

	def index
		@teacher =	Teacher.all
	end

	def create 
		@teacher = Teacher.new(teacher_params)

		if @teacher.save
			redirect_to teachers_path
		else
			render :new
		end
	end 

	def show
	end
	
	def edit
	end

	def update
		if @teacher.update(teacher_params)
			redirect_to teachers_path
		else
			render :edit
		end

	end
	def destroy 
		@teacher.destroy
		redirect_to teachers_path
	end


	private
	def teacher_params
		params.require(:teacher).permit(:name, :gender, :email, :contact)

	end

	def set_teacher
		@teacher = Teacher.find(params[:id])
	end

end