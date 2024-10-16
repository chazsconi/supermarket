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
  * `{:error, {:unknown_product_codes, product_codes}} - error if total cannot be calculated due to
    one or more unknown product codes. The list of unknown codes is returned in alphabetical order.

  """

  # GBP should probably not be hardcoded in a real system, but would require an extra parameter to be passed
  # for a multi-currency system, or fetching from a config param for a single currency system.
  def cashier([], _products), do: {:ok, Money.zero(:GBP)}

  def cashier(product_codes, products) when is_list(product_codes) do
    product_code_counts = Enum.frequencies(product_codes)

    with {:ok, product_counts} <- fetch_products(product_code_counts, products) do
      product_counts
      |> product_total_prices()
      |> Money.sum(%{})
    end
  end

  # Accumulate the product_count tuples and unknown product codes tail-recursively
  # We do this after fetching the counts so there is only one pass and if there are duplicate product codes
  # the list will be shorter
  defp fetch_products(%{} = product_code_counts, products),
    do: fetch_products(Enum.to_list(product_code_counts), products, [], [])

  defp fetch_products([], _products, product_counts_acc, []),
    do: {:ok, product_counts_acc}

  defp fetch_products([], _products, _found, unknown_codes_acc),
    do: {:error, {:unknown_product_codes, Enum.sort(unknown_codes_acc)}}

  defp fetch_products([{code, count} | rest], products, product_counts_acc, unknown_codes_acc) do
    case Products.fetch(products, code) do
      {:ok, %Product{} = product} ->
        fetch_products(
          rest,
          products,
          [{product, count} | product_counts_acc],
          unknown_codes_acc
        )

      :error ->
        fetch_products(rest, products, product_counts_acc, [code | unknown_codes_acc])
    end
  end

  defp product_total_prices(product_counts) do
    product_counts
    |> Enum.map(fn {%Product{base_price: %Money{} = base_price, price_condition: price_condition},
                    count} ->
      PriceCondition.total_price(price_condition, base_price, count)
    end)
  end
end
