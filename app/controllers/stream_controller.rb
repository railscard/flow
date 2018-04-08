class StreamController < ApplicationController
  def index
    @streams = User.find(current_user.id).streams
  end

  def create
    @stream = Stream.new(stream_params)
    @stream.save

    redirect_to action: :show, id: @stream.id
  end

  def update
    @stream = Stream.find(params[:id])
    @stream.update(code: stream_params[:code])
    filename = stream_params[:input_file].original_filename

    @download = Download.new(name: filename,
                             user_id: current_user.id,
                             stream_id: @stream.id)
    @download.save

    @stream.process(stream_params[:input_file], @download.id)

    redirect_to controller: :download, action: :show, id: @download.id
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
