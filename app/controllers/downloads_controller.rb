class DownloadsController < ApplicationController

  before_action :set_download, only: [:show, :edit, :update, :destroy]

  skip_before_filter :check_auth_token, only: [:download]

  # GET /downloads
  def index
    @downloads = Download.all.order('created_at DESC')
  end

  # GET /downloads/1
  def show
  end

  # GET /downloads/new
  def new
    @download = Download.new
  end

  # GET /downloads/1/edit
  def edit
  end

  # POST /downloads
  def create
    @download = Download.new(download_params)

    if @download.save
      redirect_to @download, notice: 'Download was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /downloads/1
  def update
    if @download.update(download_params)
      redirect_to downloads_path, notice: 'Download was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /downloads/1
  def destroy
    @download.destroy
    redirect_to downloads_url, notice: 'Download was successfully destroyed.'
  end

  def download
    @download = Download.filename_or_id(filename: params[:filename], id: params[:id])
    if @download && @download.allowed_to_download?
      send_file @download.send_update_download
    else
      raise ActionController::RoutingError.new('File could not be found or has been deleted.')
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_download
    @download = Download.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def download_params
    params.require(:download).permit(:allowed_downloads, :expires_at)
  end

end
