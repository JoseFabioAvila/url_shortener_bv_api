require 'rails_helper'

RSpec.describe ShortUrlsController, type: :controller do

  let(:parsed_response) { JSON.parse(response.body) }

  # DONE 2/2
  describe "index" do

    let!(:short_url) { ShortUrl.create(full_url: "https://www.test.rspec") }
    let(:public_attributes) do
      {
        "title"       => short_url.title,
        "full_url"    => short_url.full_url,
        "short_code"  => short_url.short_code,
        "click_count" => short_url.click_count
      }
    end

    # DONE
    it "is a successful response" do
      get :index, format: :json
      expect(response.status).to eq 200
    end

    # DONE
    it "has a list of the top 100 urls" do
      get :index, format: :json

      expect(parsed_response['urls']).to be_include(public_attributes)
    end

  end

  # DONE 2/2
  describe "create" do

    # DONE
    it "creates a short_url" do
      post :create, params: { full_url: "https://www.test.rspec" }, format: :json
      expect(parsed_response['short_code']).to be_a(String)
    end

    # DONE
    it "does not create a short_url" do
      post :create, params: { full_url: "nope!" }, format: :json
      expect(parsed_response['errors']['full_url']).to be_include("is not a valid URL")
    end

  end

  # DONE 2/3
  describe "redirect" do

    let!(:short_url) { ShortUrl.create(full_url: "https://www.test.rspec") }

    # DONE
    it "redirects to the full_url" do
      short_url.shorten_url
      get :redirect, params: { id: short_url.short_code }, format: :json
      expect(response).to redirect_to(short_url.full_url)
    end

    # DONE
    it "does not redirect to the full_url" do
      get :redirect, params: { id: "nope" }, format: :json
      expect(response.status).to eq(404)
    end

    # DONE
    it "increments the click_count for the url" do
      short_url.shorten_url
      expect { get :redirect, params: { id: short_url.short_code }, format: :json }.to change { ShortUrl.find(short_url.id).click_count }.by(1)
    end

  end

end
