require 'rails_helper'

RSpec.describe Link, type: :model do
  describe "validations" do
    it "should only save valid URLs" do

      valid_urls = %w( 
        https://google.com 
        http://yahoo.com 
        https://phys.org/news/2021-07-exotic-particle-tetraquark.html
        http://thelongestdomainnameintheworldandthensomeandthensomemoreandmore.com/
      )

      invalid_urls = %w(
        http
        https
        ftp://foo.bar
        http://
        https://
        foo
        mailto:hello@hello.com
      )
      invalid_urls << nil
      invalid_urls << ""
      invalid_urls << " "

      for url in valid_urls
        link = Link.create(url: url)
        expect(link).to be_persisted
      end

      for url in invalid_urls
        link = Link.create(url: url)
        expect(link).not_to be_persisted
      end
    end
  end

  describe "callbacks" do
    describe "#strip_whitespace" do
      it "should remove all leading and tailing whitespaces from URL" do
        test_cases = ["  https://google.com ", 
                      "\nhttps://google.com",
                      " https://google.com\n"]
        for url in test_cases
          link = Link.create!(url: url)
          expect(link.url).to eq "https://google.com"
        end
      end
    end

    describe "#assign_token" do
      it "should save a unique token of length 8 for any URL" do
        link1 = Link.create(url: "https://google.com")
        link2 = Link.create(url: "https://yahoo.com")
        expect(link1.token.length).to eq(8)
        expect(link2.token.length).to eq(8)
        expect(link1.token).not_to eq(link2.token)
      end

      it "should save a different unique tokens for the same URL" do
        link1 = Link.create(url: "https://google.com")
        link2 = Link.create(url: "https://google.com")
        expect(link1.token).not_to eq(link2.token)
      end
    end
  end
end
