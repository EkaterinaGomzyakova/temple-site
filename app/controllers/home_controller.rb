class HomeController < ApplicationController
  def index
    @date_current= params[:date] ? Date.parse(params[:date]) : Date.current

    @date = if params[:date]
          Date.parse(params[:date]).beginning_of_week
        else
          Date.current.beginning_of_week
        end

    # Создаём массив с понедельника по воскресенье
    @week_days = (@date..@date + 6.days).to_a

    @club_events = Event.club_event.includes(:club)
    if params[:club].present? && params[:club] != "ВСЕ"
      @club_events = @club_events.select { |e| e.club.name == params[:club] }
    end

    @club_names = Event.club_event.includes(:club).map { |e| e.club.name }.uniq.unshift("ВСЕ")

    @latest_news = News.where(is_published: true).order(created_at: :desc).limit(6)
    
  end
end