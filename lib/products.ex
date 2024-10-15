defmodule Supermarket.Products do
  @moduledoc """
  Functions for storing product an price configuration.
  """
  alias __MODULE__.Product

  @doc "Creates an empty product store"
  def empty, do: %{}

  @doc """
  Add a product to the products
  """
  def add(products, %Product{code: code} = product) do
    Map.put(products, code, product)
  end

  @doc """
  Fetches the product by the product code

  ## Arguments
  * `products` - Products created with `empty/1` and `add/2`
  * `code` - Product code

  ## Returns

  * `{:ok, product}` - product is a `Product` struct
  * `:error` - when unknown product code

  """
  def fetch(%{} = products, product_code) do
    Map.fetch(products, product_code)
  end
end
