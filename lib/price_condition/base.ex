defmodule Supermarket.PriceCondition.Base do
  @moduledoc "Base price condition with no discount"

  # Nothing needed in the struct
  defstruct []

  defimpl Supermarket.PriceCondition do
    def total_price(_, %Money{} = base_price, quantity) do
      Money.mult!(base_price, quantity)
    end
  end
end
