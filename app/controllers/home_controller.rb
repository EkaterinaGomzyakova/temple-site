class HomeController < ApplicationController
  def index
    # Общие вычисления (для любых типов запросов)
    @date_current = params[:date] ? Date.parse(params[:date]) : Date.current
    @date = @date_current.beginning_of_week
    @week_days = (@date..@date + 6.days).to_a

    @club_events = Event.club_event.includes(:club)
    if params[:club].present? && params[:club] != "ВСЕ"
      @club_events = @club_events.select { |e| e.club.name == params[:club] }
    end

    @club_names = Event.club_event.includes(:club).map { |e| e.club.name }.uniq.unshift("ВСЕ")
    @latest_news = News.where(is_published: true).order(created_at: :desc).limit(6)

    # Если это AJAX-запрос, рендерим только паршл календаря
    if request.xhr?
      render partial: 'calendar', layout: false
      return
    end

    # Иначе – обычный рендер полной страницы
    respond_to do |format|
      format.html
    end
  end
end