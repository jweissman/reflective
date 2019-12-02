require 'rails_helper'

RSpec.describe Card, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe 'structure' do
    it 'has a title and body' do
      card = Card.new(title: 'I saw the sign', body: 'Did it open up your eyes?')
      expect(card.title).to eq('I saw the sign')
      expect(card.body).to eq('Did it open up your eyes?')
    end
    
    it 'has a category' do
      category = Category.new(name: 'Hey, it happens')
      card = Card.new(category: category, title: 'Praise', body: 'People love public praise')
      expect(card.category.name).to eq('Hey, it happens')
    end
  
    xit 'has an order'
  end

  describe "function" do
    it 'nexts' do
      cat = Category.create({ name: "Advanced" })
      fst = Card.create(order: 1, title: "The first card", body: "is here", category: cat)
      mid = Card.create(order: 2, title: "The middle card", body: "is here", category: cat)
      lst = Card.create(order: 3, title: "The last card", body: "is here", category: cat)

      expect(fst.next).to eq(mid)
      expect(mid.next).to eq(lst)
      expect(lst.next).to eq(nil)
    end
  end
end


