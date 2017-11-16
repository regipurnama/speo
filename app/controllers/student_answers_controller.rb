class StudentAnswersController < ApplicationController 
	before_action :set_question_options, only: [:new, :show,:index,:update,:create,:edit]
	before_action :set_student_options, only: [:new, :show,:index,:update,:create,:edit]
	before_action :set_student_answers, only: [:edit,:update,:show,:destroy]

	def index
		@student_answers = StudentAnswer.includes(:student).all.page(params[:page]).per(100)
	end
	def create
		@student_answer =StudentAnswer.new(student_answers_params)
		if @student_answer.save
			redirect_to new_student_answer_path
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

	private 
	def student_answers_params
		permited_attributes = [
			:student_id,
			:question_id, 
			:response,
			:teacher_score,
		]

		permited_attributes.push(:system_score) if action_name.eql?('edit')

		params.require(:student_answer).permit(permited_attributes)
	end 

	def set_student_answers
		@student_answer = StudentAnswer.find(params[:id])
	end

	def set_question_options
		@question_options = Question.all.map{|g| [g.title, g.id]}
	end

	def set_student_options
		@student_options = Student.all.map{|g| [g.name, g.id]}
	end
end