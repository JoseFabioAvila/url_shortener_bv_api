class ShortUrl < ApplicationRecord
  include ShortUrlsHelper

  validates :full_url, presence: true
  # validate :validate_full_url

  # short_code
  def shorten_url
    self.short_code = ShortUrlsHelper.encode_base_62(id.to_i)
    save
  end

  # def update_title!
  # end

  # private

  # def validate_full_url
  # end

end
