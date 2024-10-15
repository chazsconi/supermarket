defmodule Supermarket.Products.Product do
  @moduledoc "Stores information about products and pricing"
  @enforce_keys [:code, :name, :base_price]
  defstruct [:code, :name, :base_price, price_condition: %Supermarket.PriceCondition.Base{}]
end
