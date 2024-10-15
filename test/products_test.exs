defmodule Supermarket.ProductsTest do
  use ExUnit.Case, async: true
  alias Supermarket.Products
  alias Supermarket.Products.Product

  describe "fetch/1" do
    test "known product code returns product" do
      assert {:ok, %Product{code: "CF1"}} = Products.fetch("CF1")
    end

    test "unknown product code returns error" do
      assert Products.fetch("XX") == :error
    end
  end
end
