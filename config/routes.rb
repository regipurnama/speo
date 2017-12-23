Rails.application.routes.draw do
  devise_for :accounts, controllers: {
    session:'accounts/sessions',
    registration:'accounts/registrations',
    invitations:'accounts/invitations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :students
  resources :subjects do
    collection do
      get :home
    end
  end
  resources :teachers
  resources :questions
	resources :grades
    #do
		#collection do
		#  	get :test
		#end

		# member do
		# 	get :score, path: '/score/:score_id'
		# end
	#end
  resources :exams
  resources :students_scores
  resources :student_exam_scores

  resources :student_answers do
    collection do
      get :select_exam
    end
  end

  root to:'subjects#home'
end
