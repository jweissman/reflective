require 'rails_helper'

describe "Add cards to the wall", type: :request do
    before do
        post '/api/v1/cards', params: { 
            card: { title: 'This is a good idea', body: "Let's keep doing that" }
        }
    end

    it 'returns created' do
        expect(response).to have_http_status(:created)
    end
end
