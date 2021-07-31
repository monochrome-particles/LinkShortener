class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def create
    @link = Link.create(link_params)
    if @link.save
      render json: {token: @link.token}, status: :created
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end

  def info
    if token = params['token'].presence
      if @link = Link.find_by_token(token)
        return
      end
    end
    redirect_to "/"
  end

  def redirect
    if token = params['token'].presence
      if link = Link.find_by_token(token)
        link.hits.create!(ip: request.remote_ip)
        redirect_to link.url
        return
      end
    end
    redirect_to "/"
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end
end
