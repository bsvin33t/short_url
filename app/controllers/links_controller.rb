class LinksController < ApplicationController
  def index
    @links = Link.all
  end

  def create
    link = Link.new(web_url: link_params[:web_url])
    if link.save
      flash[:success] = 'Link has been created successfully.'
    else
      flash[:error] = "#{link.errors.full_messages.join(',')}"
    end
    redirect_to(links_path)
  end

  def show
    link = Link.slug_decode(params[:slug])
    redirect_to link.web_url
  end

  private

  def link_params
    params.require(:link).permit(:web_url)
  end

end
