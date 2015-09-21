class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_filter :set_user_language

  def set_user_language
    unless current_user.nil?
      I18n.locale = current_user.locale || I18n.default_locale
    end

  end



end
