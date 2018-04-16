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
    @requests = Request.where('start_time >= ? AND start_time <= ?', temp.beginning_of_month, temp.end_of_month)
  end

  def calendar_day
    # FIXME: need to deal with lack of a valid params[:day] value
    temp = params[:day].to_date
    @requests = Request.where(
      'start_time > ? AND start_time < ?', 
      temp.to_datetime.beginning_of_day, 
      temp.to_datetime.end_of_day
    ).order('start_time asc')
    @day = temp
  end

end
