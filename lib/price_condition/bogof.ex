defmodule Supermarket.PriceCondition.Bogof do
  @moduledoc "Buy-one-get-one-free price condition"

  # Nothing needed in the struct
  defstruct []

  defimpl Supermarket.PriceCondition do
    def total_price(_, %Money{} = base_price, quantity) do
      adjusted_quantity = div(quantity, 2) + rem(quantity, 2)
      Money.mult!(base_price, adjusted_quantity)
    end
  end
end
