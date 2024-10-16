defmodule Supermarket.Products.Product do
  @moduledoc """
  Represents a single product, its price and any special pricing conditions.

  The `price_condition` field is a struct that implements `Supermarket.PriceCondition` protocol allowing
  special price conditions based on the quantity of items in a basket to be applied.
  """
  @enforce_keys [:code, :name, :base_price]
  defstruct [:code, :name, :base_price, price_condition: %Supermarket.PriceCondition.Base{}]
end
