defmodule Supermarket.ProductsTest do
  use ExUnit.Case, async: true
  alias Supermarket.Products
  alias Supermarket.Products.Product

  describe "fetch/2" do
    # This also will test `empty/0` and `add/2`
    setup do
      products =
        Products.empty()
        |> Products.add(%Product{code: "BA1", name: "Banana", base_price: Money.new(:GBP, "1.99")})
        |> Products.add(%Product{code: "AP1", name: "Apple", base_price: Money.new(:GBP, "1.20")})

      {:ok, products: products}
    end

    test "known product code returns product", %{products: products} do
      assert {:ok, %Product{code: "BA1"}} = Products.fetch(products, "BA1")
    end

    test "known 2nd product code returns product", %{products: products} do
      assert {:ok, %Product{code: "AP1"}} = Products.fetch(products, "AP1")
    end

    test "unknown product code returns error", %{products: products} do
      assert Products.fetch(products, "XX") == :error
    end

    test "product unknown on empty products" do
      assert Products.fetch(Products.empty(), "BA1") == :error
    end
  end
end
