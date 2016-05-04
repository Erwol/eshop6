class CartItem < ActiveRecord::Base
  # attr_accessible :article_id, :cart_id, :price, :amount

  belongs_to :cart
  belongs_to :article
end
