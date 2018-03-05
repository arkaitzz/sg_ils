class UsersController < ApplicationController

  hobo_user_controller

  auto_actions :all, :except => [:index, :new, :create]

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

  def do_signup
    hobo_create do
      UserMailer.new_user(this).deliver if valid?
    end
  end

  def forgot_password
    if request.post?
      user = model.find_by_email_address(params[:email_address].to_s)
      if !user.blank?
        if user.state == 'active'
          user.lifecycle.request_password_reset!(:nobody)
          render :forgot_password_email_sent
        else
          render :account_disabled
        end
      else
        render :forgot_password_no_user
      end
    end
  end

  def main_menu
    @user = current_user
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

end
