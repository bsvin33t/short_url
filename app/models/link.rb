class Link < ActiveRecord::Base

  def self.slug_decode(slug)
    row_id = 0
    base = ALPHABET.length
    slug.each_char { |c| row_id = row_id * base + ALPHABET.index(c) }
    Link.where(id: row_id).last || NullLink.new
  end

  validates :web_url, url: {no_local: true, no_scheme: true, no_spaces: true}, presence: true

  after_create :add_slug, :add_scheme


  class NullLink
    def web_url
      '/links'
    end
  end

  private

  def add_scheme
    u = URI.parse(self.web_url)
    if (!u.scheme)
      update_attributes(web_url: "http://#{web_url}")
    end
  end

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
