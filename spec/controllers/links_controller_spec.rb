require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  describe 'GET index' do
    before(:each) do
      5.times {Link.create(web_url: 'google.com')}
    end
    it 'should fetch the index of links' do
      get :index
      expect(response).to be_ok
      expect(assigns(:links)).to match_array(Link.all)
    end
  end

  describe 'POST create' do
    it 'should create a link row to the database' do
      expect{
        post :create, link: {web_url: 'google.com'}
      }.to change{Link.count}.by(1)
      expect(response).to redirect_to(links_path)
    end
  end
  
  describe 'GET show' do
    let(:link) {Link.create(web_url: 'http://example.com')}
    it 'should fetch the saved link from the db and redirect to the appropriate page' do
      get :show, slug: link.slug
      expect(response).to redirect_to 'http://example.com'
    end

    it 'should redirect to the index page if there is no link associated with the slug' do
      get :show, slug: 'x'
      expect(response).to redirect_to(links_path)
    end

  end

end
