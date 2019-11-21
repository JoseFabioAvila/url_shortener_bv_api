# Helper that helps to encode and decode url's ids in base 62
module ShortUrlsHelper
  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze
  BASE = CHARACTERS.size

  # Method to encode the given id into a base 62 code
  def self.encode_base_62(id)
    short_code = ''

    while id.positive?
      short_code.prepend(CHARACTERS[id % BASE])
      id = (id / BASE).floor
    end

    short_code
  end

  # Method to decode the given base 62 code into a id
  def self.decode_base_62(code)
    url_id = 0
    digit = 0

    code.reverse.each_char do |char|
      url_id += CHARACTERS.index(char) * (BASE**digit)
      digit += 1
    end

    url_id
  end
end
