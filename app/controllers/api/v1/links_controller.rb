class Api::V1::LinksController < ApplicationController
  def index
    render json: LinksSerializer.new(Link.all)
  end

  def create
    link = Link.new(link: params[:link], slug: params[:link])
    if link.save
      render json: LinksSerializer.new(link)
    else
      render json: {'error' => 'post unsuccessful'}, status: 404
    end
  end

  def show
    link = Link.find_by(slug: params[:slug])
    if link
      Click.create(link: link)
      render json: LinksSerializer.new(link)
    else
      render json: {'error' => 'cannot find link'}, status: 404
    end
  end

  def destroy
    link = Link.find_by(slug: params[:slug])
    if link && link.destroy
      render json: LinksSerializer.new(link)
    else
      render json: {'error' => 'cannot find link'}, status: 404
    end
  end
end