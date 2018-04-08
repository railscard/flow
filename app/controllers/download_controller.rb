class DownloadController < ApplicationController
  def index
    @downloads = User.find(current_user.id).downloads
  end

  def show
    @download = Download.find(params[:id])
    @stream = Stream.find(@download.stream_id)
    @input = Download.prettify(@download.inputs)
    @output = Download.prettify(@download.outputs)
    @errors = @download.output_errors.select(:message).distinct
    render 'download'
  end
end
