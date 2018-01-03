class RequestsController < ApplicationController

  hobo_model_controller

  auto_actions :all
  auto_actions_for :user, [:index, :new, :create]
  before_filter :set_self_user, :only => [:new_for_user]
  before_filter :set_request, :only => [:step1, :step2, :step3]

  def pre_steps_creation
    # TODO: Here we create a request attached to current user and proceed to edit on steps 1,2,3
    redirect_to request_step1_path
  end

  def step1 #TODO: Raise an exception if the user is not logged and trying to reach step1
    # This step for: DATE
    flash[:notice] = 'step1 launch for'+ current_user.name
  end

  def step2
    # This step for: PLACE
    flash[:notice] = 'step2 launch'
  end

  def step3
    # This step for: DURATION / OBSERVATIONS / SPECIAL NEEDS ...
    flash[:notice] = 'step3 launch'
  end

  def review
    # TODO: Here we review all the introduced data and confirm the request 
    flash[:notice] = 'review'
    redirect_to "/step1"
  end

  def confirm
    # TODO: Here (state changes from pending -> confirmed)
    flash[:notice] = 'confirm'
    redirect_to "/step1"
  end

  def unassigned
#    page = params[:page].blank? ? 1 : params[:page].to_i
    @request = Request.all.where(:interpreter_id => nil).paginate(:page => params[:page], :per_page => 2)
  end

# ------------------------------------------------------------------------------------------------------------------------------------#

  protected

    def set_request
      @request = Request.find(params[:request_id])
      #TODO: si el request no es de mi propiedad...
      #TODO: si el id que le paso no coincide con ningún request...
    end

    def set_self_user #No manually typing other's id's on the URL
      if params[:user_id].to_i != self.current_user.id
        redirect_to "/users/#{self.current_user.id}/requests/new"
      end
    end

end
