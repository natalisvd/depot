class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product.id)
    end
    current_item
  end

  def delete_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item.quantity > 1
      current_item.quantity -=1
    else
      line_items.destroy(product_id: product.id)
    end
  end
  def total_price
    line_items.sum(&:total_price)
  end
end
