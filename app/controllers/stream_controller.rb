class StreamController < ApplicationController
  def index
    @streams = Stream
                 .where(user_id: current_user.id)
                 .order(:created_at)
  end

  def show
    if params[:id]
      @stream = Stream.find(params[:id])
    end

    render 'stream'
  end

  def new
    render 'stream'
  end

  def destroy
    @stream = Stream.find_by(id: params[:id])
    @stream.destroy

    redirect_to action: :index
  end
end
