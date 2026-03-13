class ClubsController < ApplicationController
  before_action :set_club, only: %i[show edit update destroy]

  def index
    @clubs = Club.all
  end

  def show; end

  def new
    @club = Club.new
  end

  def edit; end

  def create
    @club = Club.new(club_params)
    @club.admin_user_id = current_user.id

    if @club.save
      redirect_to @club, notice: "Клуб создан."
    else
      render :new
    end
  end

  def update
    if @club.update(club_params)
      redirect_to @club, notice: "Клуб обновлен."
    else
      render :edit
    end
  end

  def destroy
    @club.destroy
    redirect_to clubs_path, notice: "Клуб удален."
  end

  private

  def set_club
    @club = Club.find(params[:id])
  end

  def club_params
    params.require(:club).permit(:name, :description, :slug, :position)
  end
end