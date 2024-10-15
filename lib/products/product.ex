defmodule Supermarket.Products.Product do
  @moduledoc "Represents a single product and its pricing rule"
  @enforce_keys [:code, :name, :base_price]
  defstruct [:code, :name, :base_price, price_condition: %Supermarket.PriceCondition.Base{}]
end
