class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: [:email, :accountable_id, :accountable_type])
  end

  private

  def text_pre_processor
  	@text_pre_processor ||= TextPreProcessor.new
  end
end
