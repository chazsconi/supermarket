defmodule Supermarket.PriceCondition.BulkDiscountFractionTest do
  use ExUnit.Case, async: true

  alias Supermarket.PriceCondition.BulkDiscountFraction
  alias Supermarket.PriceCondition

  @bulk_discount_fraction %BulkDiscountFraction{min_quantity: 3, discount_fraction: 2 / 3}

  test "When below min quantity" do
    assert PriceCondition.total_price(@bulk_discount_fraction, Money.new(:GBP, "2.00"), 2) ==
             Money.new(:GBP, "4.00")
  end

  test "When at min quantity" do
    assert PriceCondition.total_price(@bulk_discount_fraction, Money.new(:GBP, "2.00"), 3) ==
             Money.new(:GBP, "4.00")
  end

  test "When above min quantity" do
    assert PriceCondition.total_price(@bulk_discount_fraction, Money.new(:GBP, "2.00"), 4) ==
             Money.new(:GBP, "5.33")
  end
end
