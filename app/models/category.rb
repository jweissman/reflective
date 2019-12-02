require "ostruct"

class Category < ApplicationRecord
  has_many :cards

  def self.random
    selected = Card.pluck(:id).sample(4)
    hand = Card.includes(:category).find(selected)
    OpenStruct.new(
      {
        id: 'random',
        name: "Random Collection",
        description: "Mixing it up? Here's a random assortment of cards!",
        cards: hand,
        color: 'green',
      }
    )
  end
end
