module ShortUrlsHelper
  KEYS = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.freeze
  BASE = 62.freeze

  def self.encode_base_62(id)
    code = ''

    while id > 0
      code.prepend KEYS[id % BASE]
      id = id / BASE
    end

    code
  end

  def self.decode_base_62(code)
    id = 0
    digit = 0

    code.reverse.each_char do |char|
      id += KEYS.index(char) * (BASE ** digit)
      digit += 1
    end

    return id
  end
end
