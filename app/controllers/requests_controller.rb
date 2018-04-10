class RequestsController < ApplicationController

  hobo_model_controller

  auto_actions :all
  auto_actions_for :user, [:index, :new, :create]

  def pre_steps_creation
    @request = current_user.requests.new
    @request.save ? redirect_to request_step1_path(@request.id) : redirect_to '/', flash: { :error => I18n.t('request.error_pre_steps_creation') }
  end

  # TODO: on each step we must deny the modification of a confirmed request.
  def step1
    @hours = []
    (9..20).each{|h| ["00", "15", "30", "45"].each{ |m| @hours << "#{'%02d' % h}:#{m}" } }
    set_request
    # NOTE: In this step we set: DATE and TIME
    @request.update_attributes(params[:request])
  end

  def step2
    set_request
    # NOTE: In this step we set: PLACE
    @request.update_attributes(params[:request])
  end

  def step3
    @duration = []
    (1..8).each{|v| @duration << [v.to_s + 'h.',v]}
    set_request
    # NOTE: In this step we set: DURATION / OBSERVATIONS / SPECIAL NEEDS
    @request.update_attributes(params[:request])
  end

  def review
    set_request
    # NOTE: Here we review all the introduced data and confirm the request 
    @request.update_attributes(params[:request])
  end

  def confirm
    set_request
    # TODO: Here (state changes from pending -> confirmed)
    # TODO: Once its confirmed, do we notify by email to interpreters and the applicant?
    @request.confirm_after_review
    redirect_to '/', flash: { :notice => I18n.t('request.confirm.success').html_safe }
  end

  def my_requests
    @requests = current_user.requests
  end

  def unassigned
    @request = Request.all.where(:interpreter_id => nil).paginate(:page => params[:page], :per_page => 2)
  end

  protected

  def set_request
    @request = Request.find(params[:request_id])
    # TODO: si el request no es de mi propiedad...
    # TODO: si el id que le paso no coincide con ningún request...
    # TODO: rechazar el sistema de steps si esta confirmed a true
  end

end

