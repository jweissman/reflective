class AddCategoriesToCards < ActiveRecord::Migration[6.0]
  def change
    add_reference :cards, :category, index: true
  end
end
