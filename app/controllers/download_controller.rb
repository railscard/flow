class DownloadController < ApplicationController
  def index
    @downloads = Download
                 .where(user_id: current_user.id)
                 .order(:created_at)
  end
  def show
    if params[:id]
      @download = Download.find_by(id: params[:id])
    end

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
