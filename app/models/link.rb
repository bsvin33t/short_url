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
    temp = ''
    base = ALPHABET.length
    while self.id > 0
      temp << ALPHABET[self.id.modulo(base)]
      self.id /= base
    end
    update_attributes(slug: temp.reverse)
  end

end
