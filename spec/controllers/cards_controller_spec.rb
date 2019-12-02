require 'rails_helper'

RSpec.describe Api::V1::CardsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "limits by category" do
      category = Category.create({
        name: "Start/Stop/Keep",
        color: 'viridian'
      })
      card = Card.create({ title: "Have fun", category: category }) 
      another_card = Card.create({ title: "It's nice", category: nil }) 
      get :index, params: { category_id: category.id }
      expect(response).to have_http_status(:success)
      result = JSON.parse(response.body)
      expect(result.size).to eq(1)
      expect(result.first['title']).to eq("Have fun")
    end
  end

  describe "GET #next" do
    it "returns http success" do
      cat = Category.create({ name: "Advanced" })
      fst = Card.create(order: 1, title: "The first card", body: "is here", category: cat)
      lst = Card.create(order: 2, title: "The last card", body: "is here", category: cat)
      get :next, params: { id: fst.id }
      expect(response).to have_http_status(:success)
      result = JSON.parse(response.body)
      expect(result['title']).to eq("The last card")
    end
  end

  describe "GET #show" do
    it "returns http success" do
      cat = Category.create({ name: "Advanced" })
      card = Card.create(title: "The best card", body: "Is the one you are looking for", category: cat)

      get :show, params: { id: card.id }
      expect(response).to have_http_status(:success)
      result = JSON.parse(response.body)
      expect(result['title']).to eq("The best card")
      expect(result['body']).to eq("Is the one you are looking for")
    end
  end

  xdescribe "POST #create" do
    it "returns http success" do
      post :create, params: { card: { title: "Ace of Base", body: "All that she wants" }}
      expect(response).to have_http_status(:created)
      expect(Card.last.title).to eq("Ace of Base")
    end
  end

  xdescribe "POST #update" do
    it "returns http success" do
      card = Card.create(id: 456, title: "A temporary title", body: "can someone change this title for me")
      put :update, params: { id: 456, card: { title: "The new title" }}
      expect(response).to have_http_status(:success)
      expect(card.reload.title).to eq("The new title")
    end
  end
end
