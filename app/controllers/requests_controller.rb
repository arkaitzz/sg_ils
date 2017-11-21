class RequestsController < ApplicationController

  hobo_model_controller

  auto_actions :all
  auto_actions_for :user, [:index, :new, :create]
  before_filter :set_self_user, :only => [:new_for_user]

  def unassigned
#    page = params[:page].blank? ? 1 : params[:page].to_i
    @request = Request.all.where(:interpreter_id => nil).paginate(:page => params[:page], :per_page => 2)
  end

# ------------------------------------------------------------------------------------------------------------------------------------#

  protected

    def set_self_user #No manually typing other's id's on the URL
      if params[:user_id].to_i != self.current_user.id
        redirect_to "/users/#{self.current_user.id}/requests/new"
      end
    end

end
