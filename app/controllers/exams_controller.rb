class ExamsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_exam, only: [:show,:edit,:update,:destroy]

	def index
		@exams = Exam.all
	end

	def new
		set_question_options
		set_student_options
		@exam = Exam.new

		render :new
	end

	def create
		@exam = Exam.new(exam_params)

		if @exam.save
			redirect_to exams_path
		else
			render :new
		end
	end

	def update
		if @exam.update(exam_params)
			redirect_to exams_path
		else
			render :edit
		end
	end

	def destroy
		@exam.destroy
		redirect_to exams_path
	end

	def edit
		set_question_options
		set_student_options
	end
		# get /exam/1
	def show
	end

	private
	def exam_params
		params.require(:exam).permit(:title, :description, { question_ids: [] }, { student_ids: [] })
	end
	#take a id of exam
	def set_exam
		@exam = Exam.find(params[:id])
	end

	def set_question_options
		@question_options = Question.all.pluck(:title, :id)
	end

	def set_student_options
		@student_options = Student.all.order(name: :asc).pluck(:name, :id)
	end
end
