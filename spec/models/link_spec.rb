require 'rails_helper'

RSpec.describe Link, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:web_url) }
  end

  describe 'Slug generation' do
    it 'generates a slug for the 1st record saved in the system' do
      url = 'google.com'
      link = Link.create!(id: 1, web_url: url)
      expect(link.slug_encoding).to eq('b')
    end

    it 'generates a slug for the 2147483647th record' do
      url = 'gmail.com'
      link = Link.create!(id: 2147483647, web_url: url)
      expect(link.slug_encoding).to eq('cvuMLb')
    end

    it 'generates a slug for the 1000th record' do
      url = 'youtube.com'
      link = Link.create!(id: 1000, web_url: url)
      expect(link.slug_encoding).to eq('qi')
    end
  end
end