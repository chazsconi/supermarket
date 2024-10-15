import Config

config :supermarket, Supermarket.Product,
  products:
    [
      %Supermarket.Product{code: "GR1", name: "Green tea", base_price: Money.new(:GBP, "3.11")},
      %Supermarket.Product{
        code: "SR1",
        name: "Strawberries",
        base_price: Money.new(:GBP, "5.00")
      },
      %Supermarket.Product{code: "CF1", name: "Coffee", base_price: Money.new(:GBP, "11.23")},
      %Supermarket.Product{code: "BA1", name: "Banana", base_price: Money.new(:GBP, "1.99")},
      %Supermarket.Product{code: "AP1", name: "Apple", base_price: Money.new(:GBP, "1.20")}
    ]
    |> Map.new(&{&1.code, &1})
