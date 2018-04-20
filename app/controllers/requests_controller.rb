class RequestsController < ApplicationController

  hobo_model_controller

  auto_actions :index, :create, :update, :destroy, :show
  auto_actions_for :user, [:index]

  def pre_steps_creation
    @request = current_user.requests.new
    if @request.save
      redirect_to request_step1_path(@request.id)
    else
      redirect_to '/', flash: { :error => I18n.t('request.error_pre_steps_creation') }
    end
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
    (1..8).each{|v| @duration << [v.to_s + I18n.t('activerecord.attributes.request.start_time_append'),v]}
    set_request
    # NOTE: In this step we set: DURATION and OBSERVATIONS / SPECIAL NEEDS
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
    redirect_to '/', flash: { :notice => I18n.t('request.confirm.success', id: @request.user.id).html_safe }
  end

  def index_for_user
    # TODO: show past requests, not yet accepted ones and accepted ones
    user = User.find(params[:user_id])
    params[:sort] = 'start_time' if params[:sort].blank?
    @requests = Request.apply_scopes(
      :user_is => user
    ).order_by(
      parse_sort_param(:start_time)
    ).paginate(
      :page => params[:page], :per_page => 10
    )
    hobo_index_for :user
  end

  def unassigned
    @request = Request.where(
      :interpreter_id => nil
    ).paginate(
      :page => params[:page], :per_page => 10
    )
  end

  def show
    hobo_show :with => @request do
      respond_to do |format|
        format.html
        format.json{
          temp = {
            'start_time' => I18n.l(@request.start_time, format: :zhik),
            'duration' => @request.duration.to_s + I18n.t('activerecord.attributes.request.start_time_append'),
            'place' => @request.place,
            'observations' => @request.observations
          }
          render status: 200, json: temp.to_json
        }
      end
    end
  end

  protected

  def set_request
    @request = Request.find(params[:request_id])
    # TODO: si el request no es de mi propiedad...
    # TODO: si el id que le paso no coincide con ningún request...
    # TODO: rechazar el sistema de steps si esta confirmed a true
  end

end

