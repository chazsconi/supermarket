defmodule Supermarket.CheckoutTest do
  use ExUnit.Case, async: true
  alias Supermarket.Checkout

  describe "cashier/1 with supplied test data" do
    test "Basket 1" do
      assert Checkout.cashier(~w(GR1 SR1 GR1 GR1 CF1)) == {:ok, Money.new(:GBP, "22.45")}
    end

    test "Basket 2" do
      assert Checkout.cashier(~w(GR1 GR1)) == {:ok, Money.new(:GBP, "3.11")}
    end

    test "Basket 3" do
      assert Checkout.cashier(~w(SR1 SR1 GR1 SR1)) == {:ok, Money.new(:GBP, "16.61")}
    end

    test "Basket 4" do
      assert Checkout.cashier(~w(GR1 CF1 SR1 CF1 CF1)) == {:ok, Money.new(:GBP, "30.57")}
    end
  end

  describe "cashier/1 without special conditions" do
    test "Empty basket" do
      assert Checkout.cashier([]) == {:ok, Money.zero(:GBP)}
    end

    test "One banana" do
      assert Checkout.cashier(~w(BA1)) == {:ok, Money.new(:GBP, "1.99")}
    end

    test "Two bananas" do
      assert Checkout.cashier(~w(BA1 BA1)) == {:ok, Money.new(:GBP, "3.98")}
    end

    test "Apple and banana" do
      assert Checkout.cashier(~w(AP1 BA1)) == {:ok, Money.new(:GBP, "3.19")}
    end

    test "Unknown product_code" do
      assert Checkout.cashier(~w(AP1 XX BA1)) == {:error, {:unknown_product_code, "XX"}}
    end
  end
end
