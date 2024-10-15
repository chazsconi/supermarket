defmodule Supermarket.ProductTest do
  use ExUnit.Case, async: true
  alias Supermarket.Product

  describe "fetch/1" do
    test "known product code returns product" do
      assert {:ok, %Product{code: "CF1"}} = Product.fetch("CF1")
    end

    test "unknown product code returns error" do
      assert Product.fetch("XX") == :error
    end
  end
end
