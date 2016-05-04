class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :article

  def validate
    errors.add(:amount, "debería ser más de uno") unless amount.nil? || amount > 0
    errors.add(:price, "debería ser un número positivo") unless price.nil? || price > 0.0
  end
end
