require "rails_helper"

RSpec.describe Api::V1::CategoriesController, type: :controller do
  let!(:category) {
    Category.create({
      name: "Communication",
      color: "blue",
    })
  }
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      result = JSON.parse(response.body)
      expect(result.size).to eq(1)
      expect(result.first["name"]).to eq("Communication")
      expect(result.first["color"]).to eq("blue")
    end
  end

  describe "GET #show" do
    it "returns http success" do
      category.cards.create([{ title: "Clear" }, { title: "Constant" }])
      get :show, params: { id: category.id }
      expect(response).to have_http_status(:success)
      result = JSON.parse(response.body)
      expect(result["name"]).to eq("Communication")
      expect(result["cards"].size).to eq(2)
    end

    describe 'given the id is the string "random"' do
      it "draws randomly from all categories" do
        get :show, params: { id: "random" }
        expect(response).to have_http_status(:success)
        result = JSON.parse(response.body)
        expect(result["name"]).to eq("Random Collection")
        # expect(result["cards"].size).to eq(4)
      end
    end
  end
end
