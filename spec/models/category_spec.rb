require "rails_helper"

RSpec.describe Category, type: :model do
  describe ".random" do

    before do
      silverware = Category.create({ name: "Silver where?"})
      tools = Category.create({ name: "From the shed!"})

      Card.create({ title: "There is no spoon", category: silverware })
      Card.create({ title: "There are no rakes", category: tools })
      Card.create({ title: "There are no sporks", category: silverware })
      Card.create({ title: "There are no knives", category: silverware })
      Card.create({ title: "There are no shovels", category: tools })
    end

    it "initializes a virtual category" do
      shuffled = Category.random
      expect(shuffled[:name]).to eq("Random Collection")
      expect(shuffled[:cards].length).to eq 4
      expect(shuffled[:cards].pluck(:category_id).uniq.length).to eq 2
    end
  end
end
