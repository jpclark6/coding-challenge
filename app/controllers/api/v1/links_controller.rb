class Api::V1::LinksController < ApplicationController
  def index
    render json: LinksSerializer.new(Link.all)
  end

  def create
    link = Link.new(link: params[:link], slug: params[:link])
    if link.save
      render json: LinksSerializer.new(link)
    else
      render json: {'error' => 'post unsuccessful'}
    end
  end
end