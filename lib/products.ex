defmodule Supermarket.Products do
  @moduledoc "Functions for products"
  @doc """
  Fetches the product by the product code

  ## Arguments
  * `code` - Product code

  ## Returns

  * `{:ok, product}` - product is a `Product` struct
  * `:error` - when unknown product code

  """
  def fetch(code) do
    Application.fetch_env!(:supermarket, __MODULE__)
    |> Keyword.fetch!(:products)
    |> Map.fetch(code)
  end
end
