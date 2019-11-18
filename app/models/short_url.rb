# Short Url Model
class ShortUrl < ApplicationRecord
  include ShortUrlsHelper

  validates :full_url, presence: true, allow_blank: false
  validates :full_url, url: { 
    allow_nil: true, allow_blank: true,
    no_local: true, schemes: %w[https http]
  }

  # Shorten de given Url and save it
  def shorten_url
    self.short_code = ShortUrlsHelper.encode_base_62(id.to_i)
    if save
      UpdateTitleJob.perform_later(self)
      return true
    end

    false
  end

  # Get the url object decoded by its shorten url
  def self.decode_short_url(short_url)
    id = ShortUrlsHelper.decode_base_62(short_url)
    find(id)
  rescue StandardError
    false
  end

  # Increment the click_count field by one 
  def increment_click_count
    update(click_count: click_count + 1)
  end

  # Get the top 100 visited urls ordered descendingly
  def self.top_100
    order(click_count: :desc)
      .limit(100)
      .as_json(except: %i[id created_at updated_at])
  end

  # Invoke the brackground job to update url title
  def update_title!
    UpdateTitleJob.perform_later self
  end
end
