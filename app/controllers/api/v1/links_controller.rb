class Api::V1::LinksController < ApplicationController
  def index
    render json: LinksSerializer.new(Link.all)
  end
end