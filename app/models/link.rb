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

end
