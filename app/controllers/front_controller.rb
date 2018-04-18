class FrontController < ApplicationController

  hobo_controller

  def index
    if current_user.class == User
      redirect_to "/menu"
    end
  end

  def summary
    if !current_user.administrator?
      redirect_to user_login_path
    end
  end

  def search
    if params[:query]
      site_search(params[:query])
    end
  end

  def calendar
    temp = params[:start_date].blank? ? DateTime.now : params[:start_date].to_datetime
    case (current_user.profile rescue 'guest')
      when 'administrator'
        @requests = Request.where('start_time >= ? AND start_time <= ?', temp.beginning_of_month, temp.end_of_month)
      when 'interpreter'
        @requests = current_user.interpretation_request.where('start_time >= ? AND start_time <= ?', temp.beginning_of_month, temp.end_of_month)
      else
        redirect_to root_path
    end
  end

  def calendar_day
    temp = params[:day].to_date rescue Date.today
    @day = temp
    case (current_user.profile rescue 'guest')
      when 'administrator'
        @requests = Request.where(
          'start_time > ? AND start_time < ?', 
          temp.to_datetime.beginning_of_day, 
          temp.to_datetime.end_of_day
        ).confirmed.order('start_time asc')
      when 'interpreter'
        @requests = current_user.interpretation_request.where(
          'start_time > ? AND start_time < ?', 
          temp.to_datetime.beginning_of_day, 
          temp.to_datetime.end_of_day
        ).confirmed.order('start_time asc')
      else
        redirect_to root_path
    end
  end

end
