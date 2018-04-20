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
    temp = params[:start_date].to_datetime rescue DateTime.now
    case (current_user.profile rescue 'guest')
      when 'administrator'
        @requests = get_requests_in_a('Request', temp)
        @stats = get_requests_stats(temp)
      when 'interpreter'
        @requests = get_requests_in_a('Request', temp)
        @stats = get_requests_stats(temp)
      else
        redirect_to root_path
    end
  end

  def calendar_day
    temp = params[:day].to_date rescue Date.today
    @day = temp
    case (current_user.profile rescue 'guest')
      when 'administrator'
        @requests = get_requests_in_a('Request', temp, 'day', false)
      when 'interpreter'
        @requests = get_requests_in_a('current_user.interpretation_requests', temp, 'day', false)
      else
        redirect_to root_path
    end
  end

  private

  def get_requests_stats(date)
    temp = []
    temp << ['total', Request.count].join(CTRL_CHAR)
    temp << ['this_month', get_requests_in_a('Request', date, 'month', true)].join(CTRL_CHAR)
  end

  def get_requests_in_a(object, date, period = 'month', count = false)
    temp = eval(object).where(
      'start_time > ? AND start_time < ?', 
      eval("date.to_datetime.beginning_of_#{period}"), 
      eval("date.to_datetime.end_of_#{period}")
    ).order('start_time asc')
    count.blank? ? temp : temp.count
  end

end
