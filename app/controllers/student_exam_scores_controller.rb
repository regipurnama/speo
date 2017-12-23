class StudentExamScoresController < ApplicationController
	before_action :authenticate_user!
	before_action :set_StudentExamScore, only: [:show]


	def show
	end

	private
	def StudentExamScore_params
		params.require(:StudentExamScore).permit(:id,:student_id, :exam_id, :score, :quality)
	end
	#take a id of StudentExamScore
	def set_StudentExamScore

		@StudentExamScore = StudentExamScore.where(exam_id: params[:id])
	end

end
