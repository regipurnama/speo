
class QuestionsController < ApplicationController
	before_action :set_subject_options, only: [:show,:edit,:update,:new,:create]
	before_action :set_question, only: [:show,:edit,:update,:delete]

	def index
		@questions = Question.all.page(params[:page]).per(10)
	end

	def show
		session[:exam_id] = nil if params[:clear_exam_id].present?
		if session[:exam_id].present? || params[:exam_id].present?
			session[:exam_id] = params[:exam_id] if params[:exam_id].present?
			@exam_question = ExamQuestion.find_by(exam_id: session[:exam_id], question_id: params[:id])
			@question = @exam_question.question
			#call function process of class textpreprocessor with parameters question.key
			tokenized_question_key  = text_pre_processor.tokenize(@question.key)
			@uni_gramed_key 		    = text_pre_processor.synonymize(tokenized_question_key)
			key_sentence_collection = text_pre_processor.synonymize_as_sentences(tokenized_question_key)
			key_n_gram 					 		= NGram.new(key_sentence_collection, n: [2,3])
			answers_n_gram 					= NGram.new(@exam_question.student_answers.pluck(:response), n: [2,3])
			@bi_gramed_key          = key_n_gram.ngrams_of_all_data[2].keys
			@tri_gramed_key         = key_n_gram.ngrams_of_all_data[3].keys

			tf_processor = TermFrequencyProcessor.new(
				@uni_gramed_key,
				key_n_gram.ngrams_of_all_data[2],
				key_n_gram.ngrams_of_all_data[3],
			)

			@exam_question.student_answers.each.with_index do |student_answer, index|
				answer_word_collection  = text_pre_processor.tokenize(student_answer.response)
				student_answer.answer_term_frequency = {}
				student_answer.answer_term_frequency[:uni_gram] = tf_processor.calculate_unigram(answer_word_collection)
				student_answer.answer_term_frequency[:bi_gram]  = tf_processor.calculate_bigram(answers_n_gram.ngrams_of_inputs[index][2])
				student_answer.answer_term_frequency[:tri_gram] = tf_processor.calculate_trigram(answers_n_gram.ngrams_of_inputs[index][3])
			end
		else
			@exam_options = Exam.all.pluck(:title, :id)
			render :select_exam
		end
	end

	def new
		@question = Question.new

		render :new
	end



	def create
		@question = Question.new(question_params)

		if @question.save
			redirect_to questions_path
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @question.update(question_params)
			redirect_to questions_path
		else
			render :edit
		end


	end

	def destroy
		@question.destroy
		redirect_to questions_path
	end

	private
	def question_params
		params.require(:question).permit(:subject_id, :title, :key)
	end
		def set_subject_options
		@subject_options = Subject.all.map{|g| [g.name, g.id]}
	end


	def set_question
		@question = Question.find(params[:id])
	end

end