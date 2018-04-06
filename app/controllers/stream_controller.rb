class StreamController < ApplicationController
  def index
    @streams = Stream.where(user_id: current_user.id)
                 .order(:created_at)

  end

  def create
    @stream = Stream.new(stream_params)
    @stream.save

    redirect_to action: :show, id: @stream.id
  end

  def update
    @stream = Stream.find(params[:id])
    @stream.update_attributes(code: stream_params[:code])

    @stream.process(stream_params[:input_file])

    redirect_to action: :show, id: @stream.id
  end

  def show
    @stream = Stream.find(params[:id])
    render 'stream'
  end

  def destroy
    @stream = Stream.find(params[:id])
    @stream.destroy

    redirect_to action: :index
  end

  private

  def stream_params
    params.require(:stream).permit(:name, :user_id, :code, :input_file)
  end
end
