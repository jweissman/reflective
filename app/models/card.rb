class Card < ApplicationRecord
  belongs_to :category

  def next
    siblings[index + 1] unless last_card?
  end

  private

  def index
    siblings.index(self)
  end

  def last_card?
    index + 1 == siblings.size
  end

  def siblings
    self.category.cards.sort_by(&:order)
  end
end
