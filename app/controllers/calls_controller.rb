class CallsController < ApplicationController
  def new
      @call = call.new
  end
  
  def create
    call = call.new(call_params)
    call.user_id = current_user.id
    if call.save!
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def show
    @call = Call.find(params[:id])
  end

  def destroy
    call = Call.find(params[:id])
    call.destroy
    redirect_to action: :index
  end

  private
  def call_params
    params.require(:comment).permit(:word)
  end
end
