# Short Urls Controller
class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  # List of the 100 more visited urls
  def index
    render json: {
      status: :success,
      urls: ShortUrl::top_100
    }
  end

  # Create a new url and creates its new short code
  def create
    new_url = ShortUrl.create(permitted_params)

    if new_url.shorten_url
      return render json: {
        status: :success, short_code: new_url.short_code
      }
    end

    render json: {
      status: 400, errors: new_url.errors.messages
    }, status: :bad_request
  end

  # Redirect shorten urls to its full url
  def redirect
    if (url = ShortUrl.decode_short_url(params[:id]))
      url.increment_click_count
      return redirect_to url.full_url
    end

    render json: {
      status: 404, errors: 'Not Found'
    }, status: :not_found
  end

  private

  # Strong params
  def permitted_params
    params.permit(:full_url)
  end

end
