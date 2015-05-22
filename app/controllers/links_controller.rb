class LinksController < ApplicationController
  def index
    @links = Link.all
  end

  def create
    Link.create(web_url: link_params[:web_url])
    redirect_to(links_path)
  end

  private

  def link_params
    params.require(:link).permit(:web_url)
  end

end
