class ShortUrl < ApplicationRecord
  include ShortUrlsHelper

  validates :full_url, presence: true
  validates :full_url, url: { 
    allow_nil: true, allow_blank: true,
    no_local: true, schemes: %w[https http]
  }

  # Shorten de given Url and save it
  def shorten_url
    self.short_code = ShortUrlsHelper.encode_base_62(id.to_i)
    save
  end

  def self.decode_short_url(short_url)
    ShortUrlsHelper.decode_base_62(short_url)
  end

  def increment_click_count
    self.click_count += 1
    save
  end

  # def update_title!
  # end
end
