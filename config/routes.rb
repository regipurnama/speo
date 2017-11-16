Rails.application.routes.draw do
  resources :high_scores
  resources :students
  resources :subjects
  resources :teachers
  resources :student_answers
  resources :questions
	resources :grades do
		# collection do
		# 	get :test
		# end

		# member do
		# 	get :score, path: '/score/:score_id'
		# end
	end
end
