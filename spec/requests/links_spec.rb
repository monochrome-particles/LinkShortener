require 'rails_helper'

RSpec.describe "Links", type: :request do
  describe "GET #new" do
    it "should show the new page" do
      get "/"

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    let(:headers) { { "ACCEPT" => "application/json" } }
    context "when bad data is presented" do
      it "returns an error in JSON" do
        post "/", params: {link: {url: 'foobar'}}, headers: headers
      
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    context "when proper URL is requested" do
      it "returns the random token for the URL" do
        post "/", params: {link: {url: "https://google.com"}}

        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "GET #info" do
    let(:token) { Link.create(url: "https://foo.com").token }
    context "when non-existent token is provided" do
      it "should redirect the user to the home page" do
        get "/#{token}123/info"

        expect(response).to redirect_to "/"
      end
    end
    context "when existing token is provided" do
      it "should be successful" do
        get "/#{token}/info"

        expect(response.content_type).to eq("text/html; charset=utf-8")
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET #redirect" do
    let(:link) { Link.create(url: "https://google.com") }
    let(:token) { link.token }
    context "when non-existent token is provided" do
      it "should redirect the user to the home page" do
        get "/#{token}123"

        expect(response).to redirect_to "/"
      end
    end
    context "when existing token is provided" do
      it "should be successful" do
        get "/#{token}"

        expect(response).to redirect_to "https://google.com"
      end
      it "should keep track of the visit" do
        get "/#{token}"
        expect(link.hits.count).to eq 1

        get "/#{token}"
        expect(link.hits.count).to eq 2
      end
    end
  end
end
