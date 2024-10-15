defmodule Supermarket.Checkout do
  @moduledoc "Implements the checkout functionality of the supermarket"
  alias Supermarket.PriceCondition
  alias Supermarket.Product

  @doc """
  Calculates the total price of a basket of product codes

  ## Arguments

  * `product_codes` - List of product codes

  ## Returns

  * `{:ok, total} - total price as a `Money` struct
  * `{:error, {:unknown_product_codes, product_codes}} - error if total cannot be calculated due to unknown product code.
    The list of unknown codes is returned in alphabetical order.

  """
  # GBP should probably not be hardcoded in a real system, but would require an extra paramter to be passed
  # for a multi-currency system, or fetching from a config param for a single currency system.
  def cashier([]), do: {:ok, Money.zero(:GBP)}

  def cashier(product_codes) when is_list(product_codes) do
    product_code_frequencies = Enum.frequencies(product_codes)

    with {:ok, product_frequencies} <- fetch_products(product_code_frequencies) do
      product_frequencies
      |> Enum.map(fn {%Product{} = product, frequency} ->
        product_total_price(product, frequency)
      end)
      |> Money.sum(%{})
    end
  end

  defp fetch_products(%{} = product_code_frequencies),
    do: fetch_products(Enum.to_list(product_code_frequencies), [], [])

  defp fetch_products([], found, []),
    do: {:ok, found}

  # Accumulate the found and not_found products tail-recursively
  defp fetch_products([], _found, not_found),
    do: {:error, {:unknown_product_codes, Enum.sort(not_found)}}

  defp fetch_products([{code, frequency} | rest], found, not_found) do
    case Product.fetch(code) do
      {:ok, %Product{} = product} ->
        fetch_products(rest, [{product, frequency} | found], not_found)

      :error ->
        fetch_products(rest, found, [code | not_found])
    end
  end

  defp product_total_price(
         %Product{base_price: %Money{} = base_price, price_condition: price_condition},
         frequency
       ) do
    PriceCondition.total_price(price_condition, base_price, frequency)
  end
end
