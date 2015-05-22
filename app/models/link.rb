class Link < ActiveRecord::Base

  validates :web_url, presence: true

  ALPHABET =
      "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".split(//)

  def slug_encoding
    return ALPHABET[0] if self.id == 0
    slug = ''
    base = ALPHABET.length
    while self.id > 0
      slug << ALPHABET[self.id.modulo(base)]
      self.id /= base
    end
    slug.reverse
  end

  def self.slug_decoding(slug)
    id = 0
    base = ALPHABET.length
    slug.each_char { |c| id = id * base + ALPHABET.index(c) }
    Link.where(id: id).last || NullLink.new
  end


  class NullLink
    def web_url
      '/links'
    end
  end

end
