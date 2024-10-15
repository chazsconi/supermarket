defmodule Supermarket.Checkout do
  @moduledoc "Implements the checkout functionality of the supermarket"
  alias Supermarket.PriceCondition
  alias Supermarket.Products
  alias Supermarket.Products.Product

  @doc """
  Calculates the total price of a basket of product codes

  ## Arguments

  * `product_codes` - List of product codes
  * `products` - Products created using the `Products` module

  ## Returns

  * `{:ok, total} - total price as a `Money` struct
  * `{:error, {:unknown_product_codes, product_codes}} - error if total cannot be calculated due to unknown product code.
    The list of unknown codes is returned in alphabetical order.

  """
  # GBP should probably not be hardcoded in a real system, but would require an extra paramter to be passed
  # for a multi-currency system, or fetching from a config param for a single currency system.
  def cashier([], _products), do: {:ok, Money.zero(:GBP)}

  def cashier(product_codes, products) when is_list(product_codes) do
    product_code_frequencies = Enum.frequencies(product_codes)

    with {:ok, product_frequencies} <- fetch_products(product_code_frequencies, products) do
      product_frequencies
      |> Enum.map(fn {%Product{} = product, frequency} ->
        product_total_price(product, frequency)
      end)
      |> Money.sum(%{})
    end
  end

  defp fetch_products(%{} = product_code_frequencies, products),
    do: fetch_products(Enum.to_list(product_code_frequencies), products, [], [])

  defp fetch_products([], _products, found, []),
    do: {:ok, found}

  # Accumulate the found and not_found products tail-recursively
  defp fetch_products([], _products, _found, not_found),
    do: {:error, {:unknown_product_codes, Enum.sort(not_found)}}

  defp fetch_products([{code, frequency} | rest], products, found, not_found) do
    case Products.fetch(products, code) do
      {:ok, %Product{} = product} ->
        fetch_products(rest, products, [{product, frequency} | found], not_found)

      :error ->
        fetch_products(rest, products, found, [code | not_found])
    end
  end

  defp product_total_price(
         %Product{base_price: %Money{} = base_price, price_condition: price_condition},
         frequency
       ) do
    PriceCondition.total_price(price_condition, base_price, frequency)
  end
end
