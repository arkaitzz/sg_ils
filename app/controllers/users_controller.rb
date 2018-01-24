class UsersController < ApplicationController

  hobo_user_controller

  auto_actions :all, :except => [:index, :new, :create]

  before_filter :set_user, :only => [:main_menu, :role_set]

  # Normally, users should be created via the user lifecycle, except
  #  for the initial user created via the form on the front screen on
  #  first run.  This method creates the initial user.
  def create
    hobo_create do
      if valid?
        self.current_user = this
        flash[:notice] = t('user.actions.create')
        UserMailer.new_user(current_user).deliver
        redirect_to home_page
      end
    end
  end

  def main_menu
    # Set user
    @user_type = current_user.user_type
  end

  def role_set
    if !current_user.administrator?
      flash[:notice] = I18n.t('user_forbidden')
      redirect_to '/'
    end
    # Set user
    @user = User.all
    @applicants = User.all.applicant
    @interpreters = User.all.interpreter
    hobo_ajax_response if request.xhr?
  end

  protected

  def set_user
    # If user is a Guest, redirect to front page
    redirect_to '/' if current_user.class != User
    @user = current_user
  end

end
