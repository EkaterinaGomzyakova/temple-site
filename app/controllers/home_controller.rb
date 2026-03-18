class HomeController < ApplicationController
  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.current

    @week_days = (@date..@date + 6.days).to_a

    @club_events = Event.club_event.includes(:club)
    if params[:club].present? && params[:club] != "ВСЕ"
      @club_events = @club_events.select { |e| e.club.name == params[:club] }
    end

    @club_names = Event.club_event.includes(:club).map { |e| e.club.name }.uniq.unshift("ВСЕ")

    @latest_news = News.where(is_published: true).order(created_at: :desc).limit(6)
    
  end
end