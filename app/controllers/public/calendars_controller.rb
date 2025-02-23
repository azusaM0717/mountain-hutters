class Public::CalendarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_calendar, only: [:edit, :update, :destroy]

  def new
    @calendar = current_user.calendar.new
  end

  def index
    @calendars = current_user.calendars
    @huts = Hut.all

    respond_to do |format|
      format.html  # 通常のHTML表示
      format.json { render json: @calendars.map { |calendar| 
        { 
          id: calendar.id,
          title: calendar.hut.name,
          start: calendar.start_date,
          end: calendar.end_date
        } 
      }}
    end
  end

  def events
    @calendars = current_user.calendars
    Rails.logger.info "User's Calendars: #{@calendars.inspect}"
    events = @calendars.map do |calendar|
      {
        title: calendar.hut.name,
        start: calendar.start_date,
        end: calendar.end_date,
      }
    end
    Rails.logger.info "Events: #{events.inspect}"
    render json: events
  end

  # CalendarsController
def create
  @calendar = current_user.calendars.new(calendar_params)

  if @calendar.save
    render json: {
      id: @calendar.id,
      title: @calendar.hut.name,  # ここでhutの名前をtitleに設定
      start: @calendar.start_date,
      end: @calendar.end_date
    }, status: :created
  else
    render json: { errors: @calendar.errors.full_messages }, status: :unprocessable_entity
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
    params.require(:calendar).permit(:start_date, :end_date, :hut_id)
  end
end
