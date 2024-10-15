import Config

alias Supermarket.Product
alias Supermarket.PriceCondition.{Bogof, BulkDiscountPrice, BulkDiscountFraction}

# Config is in runtime.exs so we can use structs
config :supermarket, Supermarket.Product,
  products:
    [
      %Product{
        code: "GR1",
        name: "Green tea",
        base_price: Money.new(:GBP, "3.11"),
        price_condition: %Bogof{}
      },
      %Product{
        code: "SR1",
        name: "Strawberries",
        base_price: Money.new(:GBP, "5.00"),
        price_condition: %BulkDiscountPrice{
          min_quantity: 3,
          discount_price: Money.new(:GBP, "4.50")
        }
      },
      %Product{
        code: "CF1",
        name: "Coffee",
        base_price: Money.new(:GBP, "11.23"),
        price_condition: %BulkDiscountFraction{
          min_quantity: 3,
          discount_fraction: 2 / 3
        }
      },
      %Product{code: "BA1", name: "Banana", base_price: Money.new(:GBP, "1.99")},
      %Product{code: "AP1", name: "Apple", base_price: Money.new(:GBP, "1.20")}
    ]
    |> Map.new(&{&1.code, &1})
