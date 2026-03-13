class NewsController < ApplicationController
  before_action :set_news, only: %i[show edit update destroy]

  def index
    @news = News.all
  end

  def show; end

  def new
    @news = News.new
  end

  def edit; end

  def create
    @news = News.new(news_params)
    @news.created_by = current_user

    if @news.save
      redirect_to @news, notice: "Новость создана."
    else
      render :new
    end
  end

  def update
    if @news.update(news_params)
      redirect_to @news, notice: "Новость обновлена."
    else
      render :edit
    end
  end

  def destroy
    @news.destroy
    redirect_to news_index_path, notice: "Новость удалена."
  end

  private

  def set_news
    @news = News.find(params[:id])
  end

  def news_params
    params.require(:news).permit(:title, :content, :slug, :position, :is_published, images: [])
  end
end