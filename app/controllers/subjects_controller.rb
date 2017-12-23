class SubjectsController < ApplicationController
	before_action :authenticate_account!
	before_action :set_teacher_options, only:[:edit,:new,:update,:create]
	before_action :set_subject, only: [:edit,:show,:update,:destroy]
	def index
		@subjects = Subject.all
	end

	def home
		render :home
	end

	def show
	end

	def new
		@subject = Subject.new
		render :new
	end

	def create
		@subject = Subject.new(subject_params)
		if @subject.save
			redirect_to subjects_path
		else
			render :new
		end

	end
	def edit
		render :edit
	end
	def update
		if @subject.update(subject_params)
			redirect_to subjects_path
		else
			render :edit
		end

	end
	def destroy
		@subject.destroy
		redirect_to subjects_path
	end

	private
	def subject_params
		params.require(:subject).permit(:teacher_id, :name)
	end

	def set_teacher_options
		@teacher_options = Teacher.all.map{|g| [g.name, g.id]}
	end

	def set_subject
		@subject = Subject.find(params[:id])
	end

end