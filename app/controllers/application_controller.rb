class ApplicationController < ActionController::Base
  helper_method :signed_in?, :current_user

  include SessionsHelper

  protect_from_forgery with: :exception
end
