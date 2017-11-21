class UsersController < ApplicationController

  hobo_user_controller

  auto_actions :all, :except => [:new, :create]

  before_filter :set_user, :only => [:main_menu, :role_set]

  # Normally, users should be created via the user lifecycle, except
  #  for the initial user created via the form on the front screen on
  #  first run.  This method creates the initial user.
  def create
    hobo_create do
      if valid?
        self.current_user = this
        flash[:notice] = t("hobo.messages.you_are_site_admin", :default=>"You are now the site administrator")
        redirect_to home_page
      end
    end
  end

  def main_menu
    #set_user
    @user_type = current_user.user_type
    logger.info("+++++ARK+++++ "+ current_user.user_type.to_s)
  end

  def role_set
    if current_user.user_type != 'Administrator'
      flash[:notice] = 'Forbidden'
      redirect_to "/"
    end
    #set_user
    @user = User.all
    @applicants = User.all.applicant
    @interpreters= User.all.interpreter
  hobo_ajax_response if request.xhr?
  end


# ------------------------------------------------------------------------------------------------------------------------------------#

  protected

    def set_user #If a guest, redirected to login page
      if current_user.class != User
        redirect_to "/login"
      end
      @user = current_user
    end

end
