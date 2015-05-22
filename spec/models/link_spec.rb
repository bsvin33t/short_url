require 'rails_helper'

RSpec.describe Link, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:web_url) }
  end

  describe 'Slug generation' do
    it 'generates a slug for the 1st record saved in the system' do
      url = 'google.com'
      link = Link.create!(id: 1, web_url: url)
      expect(link.slug).to eq('b')
    end

    it 'generates a slug for the 2147483647th record' do
      url = 'gmail.com'
      link = Link.create!(id: 2147483647, web_url: url)
      expect(link.slug).to eq('cvuMLb')
    end

    it 'generates a slug for the 1000th record' do
      url = 'youtube.com'
      link = Link.create!(id: 1000, web_url: url)
      expect(link.slug).to eq('qi')
    end
  end


  describe 'Slug Decoding' do
    it 'decodes slug for the 1st record in the system' do
      url = 'google.com'
      Link.create(id: 1, web_url: url)
      expect(Link.slug_decode('b')).to eq(Link.first)
    end

    it 'returns a NullLink object if decoding for slug is not available' do
      expect(Link.slug_decode('x')).to be_kind_of(Link::NullLink)
    end
  end

  describe 'after save' do
    it 'should get prepended with `http` if there is no scheme attached' do
      url = 'google.com'
      link = Link.create!(web_url: url)
      expect(link.web_url).to eq("http://#{url}")
    end

    it 'should not modify the existing schema' do
      url = 'ftp://myweb.co'
      link = Link.create!(web_url: url)
      expect(link.web_url).to eq(url)
    end
  end

end
