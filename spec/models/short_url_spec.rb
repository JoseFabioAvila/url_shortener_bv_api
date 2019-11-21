require 'rails_helper'

RSpec.describe ShortUrl, type: :model do

  # DONE 1/1
  describe "ShortUrl" do

    let(:short_url) { ShortUrl.create(full_url: "https://www.beenverified.com/faq/") }

    # DONE
    it "finds a short_url with the short_code" do
      short_url.shorten_url
      expect(ShortUrl.find_by_short_code(short_url.short_code)).to eq short_url
    end

  end

  # DONE 3/3
  describe "a new short_url instance" do

    let(:short_url) { ShortUrl.new }

    # DONE
    it "isn't valid without a full_url" do
      expect(short_url).to_not be_valid
      expect(short_url.errors[:full_url]).to be_include("can't be blank")
    end

    # DONE
    it "has an invalid url" do
      short_url.full_url = 'javascript:alert("Hello World");'
      expect(short_url).to_not be_valid
      expect(short_url.errors[:full_url]).to be_include("is not a valid URL")
    end

    # DONE
    it "doesn't have a short_code" do
      expect(short_url.short_code).to be_nil
    end

  end

  # DONE 3/4
  describe "existing short_url instance" do

    let(:short_url) { ShortUrl.create(full_url: "https://www.beenverified.com/faq/") }

    # DONE
    it "has a short code" do
      short_url.shorten_url
      expect(short_url.short_code).to be_a(String)
    end

    # DONE
    it "has a click_counter" do
      expect(short_url.click_count).to eq 0
    end

    it "fetches the title" do
      short_url.update_title!
      expect(short_url.title).to eq("Frequently Asked Questions | BeenVerified")
    end

    # DONE 2/2
    context "with a higher id" do

      # Instead of creating a bunch of ShortUrls to get a higher
      # id, let's just manipulate the one we have.

      # DONE
      it "has the short_code for id 1001" do
        short_url.update_column(:id, 1001)
        short_url.shorten_url
        expect(short_url.short_code).to eq("g9")
      end

      # DONE
      it "has the short_code for id for 50" do
        short_url.update_column(:id, 50)
        short_url.shorten_url
        expect(short_url.short_code).to eq("O")
      end
    end

  end

end
