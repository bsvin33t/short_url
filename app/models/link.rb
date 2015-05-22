class Link < ActiveRecord::Base

  def self.slug_decode(slug)
    row_id = 0
    base = ALPHABET.length
    slug.each_char { |c| row_id = row_id * base + ALPHABET.index(c) }
    Link.where(id: row_id).last || NullLink.new
  end

  validates :web_url, presence: true

  after_create :add_slug


  class NullLink
    def web_url
      '/links'
    end
  end

  private

  def add_slug
    update_attributes(slug: slug_encode(id))
  end


  def slug_encode(i)
    return ALPHABET[0] if i == 0
    s = ''
    base = ALPHABET.length
    while i > 0
      s << ALPHABET[i.modulo(base)]
      i /= base
    end
    s.reverse
  end
end
