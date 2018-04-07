class DownloadController < ApplicationController
  def index
    @downloads = Download
                 .where(user_id: current_user.id)
                 .order(created_at: :desc)
  end

  def history
    @download = Download.find_by(id: params[:id])

    render 'download/history'
  end

  def show
    @download = Download.find_by(id: params[:id])
    @input = Input.where(download_id: @download.id)
    @output = Output.where(download_id: @download.id)
    @errors = OutputError.select(:message).where(download_id: @download.id).distinct
    render 'download'
  end

  def new
    render 'download'
  end

  def destroy
    @download = Download.find(params[:id])
    @download.destroy

    redirect_to action: :index
  end
end
