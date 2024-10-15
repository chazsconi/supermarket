defmodule Supermarket.CheckoutTest do
  use ExUnit.Case, async: true
  alias Supermarket.Checkout

  describe "cashier with supplied test data" do
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
end
