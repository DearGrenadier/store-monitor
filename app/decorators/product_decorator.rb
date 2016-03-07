class ProductDecorator < Draper::Decorator
  delegate_all

  X = 'x'

  def sorted
    object.product_attrs
      .sort { |a, b| a.size.value.delete(X).to_i <=> b.size.value.delete(X).to_i }
  end
end
