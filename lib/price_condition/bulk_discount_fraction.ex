defmodule Supermarket.PriceCondition.BulkDiscountFraction do
  @moduledoc """
  Price condition where the price of all items is discounted by a fraction if the
  minimum quantity of items is exceeded
  """

  @enforce_keys [:min_quantity, :discount_fraction]
  defstruct [
    # Min quantity at which the discount applies
    :min_quantity,
    # A float indicating the discount of the original price.  e.g. 0.9 would be 10% off
    :discount_fraction
  ]

  defimpl Supermarket.PriceCondition do
    alias Supermarket.PriceCondition.BulkDiscountFraction

    def total_price(
          %BulkDiscountFraction{min_quantity: min, discount_fraction: discount_fraction},
          %Money{} = base_price,
          quantity
        )
        when quantity >= min do
      base_price
      |> Money.mult!(discount_fraction)
      |> Money.mult!(quantity)
      # Round the price at the end
      # Alternatively, to give a clear price to the customer per item
      # you could round before multiplying by quantity
      |> Money.round()
    end

    def total_price(_, %Money{} = base_price, quantity) do
      Money.mult!(base_price, quantity)
    end
  end
end
