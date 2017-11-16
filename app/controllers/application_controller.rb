class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def text_pre_processor
  	@text_pre_processor ||= TextPreProcessor.new
  end
end
