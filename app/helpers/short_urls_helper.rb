module ShortUrlsHelper
  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze
  BASE = CHARACTERS.size

  def self.encode_base_62(id)
    short_code = ''

    while id.positive?
      short_code.prepend(CHARACTERS[id % BASE])
      id = (id / BASE).floor
    end

    short_code
  end

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
