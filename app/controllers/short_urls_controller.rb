class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
    render json: {
      status: :success,
      data: ShortUrl.all
    }
  end

  def create
    new_url = ShortUrl.create(permitted_params)

    if new_url.shorten_url
      return render json: {
        status: :success, data: new_url
      }
    end

    render json: {
      status: 400, errors: new_url.errors.messages
    }, status: :bad_request
  end

  def show
    url = ShortUrl.find(params[:id])

    if url
      return render json: {
        status: :success, data: url
      }
    end

    render json: {
      status: 400, errors: url.errors.messages
    }, status: :bad_request
  end

  def redirect
    id = ShortUrl.decode_short_url(params[:id])
    url = ShortUrl.find(id)
    url.increment_click_count

    return redirect_to url.full_url if url

    render json: {
      status: 404, errors: 'Not Found'
    }, status: :not_found
  end

  private

  def permitted_params
    params.permit(:full_url)
  end

end
