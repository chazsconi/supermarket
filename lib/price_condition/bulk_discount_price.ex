defmodule Supermarket.PriceCondition.BulkDiscountPrice do
  @moduledoc "Buy one get one free price condition"

  @enforce_keys [:min_quantity, :discount_price]
  defstruct [
    # Min quantity at which the discount applies
    :min_quantity,
    # A `Money` struct with the discounted price
    :discount_price
  ]

  defimpl Supermarket.PriceCondition do
    alias Supermarket.PriceCondition.BulkDiscountPrice

    def total_price(
          %BulkDiscountPrice{min_quantity: min, discount_price: %Money{} = discount_price},
          _base_price,
          quantity
        )
        when quantity >= min do
      Money.mult!(discount_price, quantity)
    end

    def total_price(_, %Money{} = base_price, quantity) do
      Money.mult!(base_price, quantity)
    end
  end
end
