# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/recipes/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show', :vcr do
    context 'on success' do
      it 'returns http success' do
        get '/recipes/4dT8tcb6ukGSIg2YyuGEOm'
        expect(response).to have_http_status(:success)
      end
    end

    context 'on failure' do
      it 'is a bad request and shows a message of no data was found' do
        get '/recipes/172638176237812'
        expect(response.body).to include('No data was found for id 172638176237812')
      end
    end
  end
end
