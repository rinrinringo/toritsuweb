class LessonsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

  def index
    if params[:search] != nil && params[:search] != ''
      #部分検索かつ複数検索
      search = params[:search]
      @lessons = Lesson.joins(:user).where("jugyou LIKE ? OR youbi LIKE ?", "%#{search}%", "%#{search}%")
    else
      @lessons = Lesson.all
    end
  end

  def new
      @lesson = Lesson.new
  end
  
  def create
    lesson = Lesson.new(lesson_params)
    lesson.user_id = current_user.id
    if lesson.save!
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def show
    @lesson = Lesson.find(params[:id])
  end   

  def destroy
    lesson = Lesson.find(params[:id])
    lesson.destroy
    redirect_to action: :index
  end
    
  private
  def lesson_params
    params.require(:lesson).permit(:jugyou, :youbi, :repo, :overall,:level)
  end
end
