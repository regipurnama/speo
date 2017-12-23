class Accounts::InvitationsController < Devise::InvitationsController
  before_action :set_student_options, only: [:new]
  before_action :set_teacher_options, only: [:new]

  def update
    super
  end

  def new
    super
  end

  def create
    super
  end

  private
  def set_student_options
    @student_options = Student.all.map{|g| [g.name, g.id]}
  end
  def set_teacher_options
    @teacher_options = Teacher.all.map{|g| [g.name, g.id]}
  end
end