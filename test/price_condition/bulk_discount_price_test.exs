defmodule Supermarket.PriceCondition.BulkDiscountPriceTest do
  use ExUnit.Case, async: true

  alias Supermarket.PriceCondition.BulkDiscountPrice
  alias Supermarket.PriceCondition

  @bulk_discount_price %BulkDiscountPrice{
    min_quantity: 3,
    discount_price: Money.new(:GBP, "1.00")
  }

  test "When below min quantity" do
    assert PriceCondition.total_price(@bulk_discount_price, Money.new(:GBP, "2.00"), 2) ==
             Money.new(:GBP, "4.00")
  end

  test "When at min quantity" do
    assert PriceCondition.total_price(@bulk_discount_price, Money.new(:GBP, "2.00"), 3) ==
             Money.new(:GBP, "3.00")
  end

  test "When above min quantity" do
    assert PriceCondition.total_price(@bulk_discount_price, Money.new(:GBP, "2.00"), 4) ==
             Money.new(:GBP, "4.00")
  end
end
