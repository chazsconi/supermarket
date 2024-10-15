defmodule Supermarket.PriceCondition.BogofTest do
  use ExUnit.Case, async: true

  alias Supermarket.PriceCondition.Bogof
  alias Supermarket.PriceCondition

  test "With 1 item" do
    assert PriceCondition.total_price(%Bogof{}, Money.new(:GBP, "1.00"), 1) ==
             Money.new(:GBP, "1.00")
  end

  test "With 2 items" do
    assert PriceCondition.total_price(%Bogof{}, Money.new(:GBP, "1.00"), 2) ==
             Money.new(:GBP, "1.00")
  end

  test "With 3 items" do
    assert PriceCondition.total_price(%Bogof{}, Money.new(:GBP, "1.00"), 3) ==
             Money.new(:GBP, "2.00")
  end

  test "With 4 items" do
    assert PriceCondition.total_price(%Bogof{}, Money.new(:GBP, "1.00"), 4) ==
             Money.new(:GBP, "2.00")
  end
end
