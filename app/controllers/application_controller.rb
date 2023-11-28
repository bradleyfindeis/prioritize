# frozen_string_literal: true

# Purpose: Main controller for the application. All other controllers inherit from this controller.
class ApplicationController < ActionController::Base

  def set_user
    @user = User.find_by(email: params[:email])
  end
end
