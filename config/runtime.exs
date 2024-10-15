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
      %Supermarket.Product{code: "CF1", name: "Coffee", base_price: Money.new(:GBP, "11.23")}
    ]
    |> Map.new(&{&1.code, &1})
