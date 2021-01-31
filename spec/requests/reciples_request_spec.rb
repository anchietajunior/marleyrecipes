require 'rails_helper'

RSpec.describe "Reciples", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/reciples/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/reciples/show"
      expect(response).to have_http_status(:success)
    end
  end

end
