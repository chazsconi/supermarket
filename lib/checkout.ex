defmodule Supermarket.Checkout do
  @moduledoc "Implements the checkout functionality of the supermarket"

  @doc """
  Calculates the total price of a basket of product codes

  ## Arguments

  * `product_codes` - List of product codes

  ## Returns

  * `{:ok, total} - total price as a `Money` struct
  * `{:error, reason} - error if total cannot be calculated, e.g. invalid product code is present

  """
  def cashier(product_codes) when is_list(product_codes) do
    {:error, :not_implemented}
  end
end
