class StudentAnswersController < ApplicationController
	before_action :authenticate_user!
	before_action :authenticate_exam_id, except: [:select_exam]
	before_action :set_question_options, only: [:new, :show,:index,:update,:create,:edit]
	before_action :set_student_options, only: [:new, :show,:index,:update,:create,:edit]
	before_action :set_exam_options, only: [:select_exam]
	before_action :set_student_answer, only: [:edit,:update,:show,:destroy]

	def index
		@student_answers = set_student_answers.page(params[:page]).per(450)
	end

	def create
		@student_answer = StudentAnswer.new(student_answers_params)
		if @student_answer.save
			redirect_to student_answers_path
		else
			render :new
		end
	end

	def new
		@student_answer = StudentAnswer.new
		render :new
	end

	def edit
	end

	def update
		if @student_answer.update(student_answers_params)
			redirect_to student_answers_path
		else
			render :edit
		end
	end

	def show
	end

	def destroy
		@student_answer.destroy
		redirect_to student_answers_path
	end

	def select_exam
		render :select_exam
	end

	private
	def student_answers_params
		permited_attributes = [
			:student_id,
			:exam_question_id,
			:response,
			:teacher_score,
		]

		permited_attributes.push(:system_score) if action_name.eql?('edit')

		params.require(:student_answer).permit(permited_attributes)
	end

	def set_student_answer
		@student_answer = set_student_answers.find(params[:id])
	end

	def set_student_options
		@student_options = Student.all.map{|g| [g.name, g.id]}
	end

	def set_exam_options
		@exam_options = Exam.all.pluck(:title, :id)
	end

	def set_question_options
		@question_options = ExamQuestion.where(exam_id: session[:exam_id])
			.includes(:question)
			.pluck(:title, :id)
	end

	def set_student_answers
		StudentAnswer.includes(:student)
			.joins(:exam_question)
			.where(exam_questions: { exam_id: session[:exam_id] })
	end

	def authenticate_exam_id
		if params[:exam_id].present?
			session[:exam_id] = params[:exam_id]
		elsif session[:exam_id].blank?
			return redirect_to(request.referrer || select_exam_student_answers_path)
		end
	end
end