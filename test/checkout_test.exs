defmodule Supermarket.CheckoutTest do
  use ExUnit.Case, async: true
  alias Supermarket.Checkout
  alias Supermarket.Products
  alias Supermarket.Products.Product
  alias Supermarket.PriceCondition.{Bogof, BulkDiscountPrice, BulkDiscountFraction}

  describe "cashier/2 with supplied test data" do
    setup do
      products =
        Products.empty()
        |> Products.add(%Product{
          code: "GR1",
          name: "Green tea",
          base_price: Money.new(:GBP, "3.11"),
          price_condition: %Bogof{}
        })
        |> Products.add(%Product{
          code: "SR1",
          name: "Strawberries",
          base_price: Money.new(:GBP, "5.00"),
          price_condition: %BulkDiscountPrice{
            min_quantity: 3,
            discount_price: Money.new(:GBP, "4.50")
          }
        })
        |> Products.add(%Product{
          code: "CF1",
          name: "Coffee",
          base_price: Money.new(:GBP, "11.23"),
          price_condition: %BulkDiscountFraction{
            min_quantity: 3,
            discount_fraction: 2 / 3
          }
        })

      {:ok, products: products}
    end

    test "Basket 1", %{products: products} do
      assert Checkout.cashier(~w(GR1 SR1 GR1 GR1 CF1), products) ==
               {:ok, Money.new(:GBP, "22.45")}
    end

    test "Basket 2", %{products: products} do
      assert Checkout.cashier(~w(GR1 GR1), products) == {:ok, Money.new(:GBP, "3.11")}
    end

    test "Basket 3", %{products: products} do
      assert Checkout.cashier(~w(SR1 SR1 GR1 SR1), products) == {:ok, Money.new(:GBP, "16.61")}
    end

    test "Basket 4", %{products: products} do
      # The result of this depends on if you calculate the discounted coffee price of 2/3rds
      # before or after summing the coffees.  This test assumes it is done after summing
      # If you discount (and round) the price before summing the total would be 30.58
      assert Checkout.cashier(~w(GR1 CF1 SR1 CF1 CF1), products) ==
               {:ok, Money.new(:GBP, "30.57")}
    end
  end

  describe "cashier/2 without special conditions" do
    setup do
      products =
        Products.empty()
        |> Products.add(%Product{code: "BA1", name: "Banana", base_price: Money.new(:GBP, "1.99")})
        |> Products.add(%Product{code: "AP1", name: "Apple", base_price: Money.new(:GBP, "1.20")})

      {:ok, products: products}
    end

    test "Empty basket", %{products: products} do
      assert Checkout.cashier([], products) == {:ok, Money.zero(:GBP)}
    end

    test "One banana", %{products: products} do
      assert Checkout.cashier(~w(BA1), products) == {:ok, Money.new(:GBP, "1.99")}
    end

    test "Two bananas", %{products: products} do
      assert Checkout.cashier(~w(BA1 BA1), products) == {:ok, Money.new(:GBP, "3.98")}
    end

    test "Apple and banana", %{products: products} do
      assert Checkout.cashier(~w(AP1 BA1), products) == {:ok, Money.new(:GBP, "3.19")}
    end

    test "Unknown product_code", %{products: products} do
      assert Checkout.cashier(~w(AP1 YY BA1 XX), products) ==
               {:error, {:unknown_product_codes, ~w(XX YY)}}
    end
  end
end
