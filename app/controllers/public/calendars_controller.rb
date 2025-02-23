class Public::CalendarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_calendar, only: [:edit, :update, :destroy]

  def index
    @calendars = current_user.calendars
  end

  def new
    @calendar = current_user.calendars.new
  end

  def create
    @calendar = @user.calendars.new(calendar_params)
    if @calendar.save
      redirect_to mypage_calendars_path, notice: "登山スケジュールを追加しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @calendar.update(calendar_params)
      redirect_to mypage_calendars_path, notice: "登山スケジュールを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @calendar.destroy
    redirect_to mypage_calendars_path, notice: "登山スケジュールを削除しました"
  end

  private
  def set_calendar
    @calendar = current_user.calendars.find(params[:id])
  end

  def calendar_params
    params.require(:calendar).permit(:title, :start_date, :end_date)
  end
end
