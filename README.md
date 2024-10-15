# Supermarket

Programming challenge.

## Setup

Run `mix deps.get`

## Run tests

Run `mix test`

## Design choices

### Configuration

The product and price configuration are built using the `Products` module and passed to the `Checkout.cashier/2` function.  This allows for easy testing as different product lists can be used for different tests.

An alternative (which I tried initially and the refactored) would be to set the product and price configuration in `runtime.exs` thus allowing us to use structs (which wouldn't be possible in other config files).  This would mean that `Checkout.cashier` would just take a single argument of a list of product codes as the products and price configuration would be fetched from the config in the `Checkout` module functions.

In a real system the product list would probably come from a DB and then could be deserialised to structs (e.g. using `Ecto`) and optimised by caching in memory.

### Special Price Conditions

These are implemented using a protocol thus allowing easy adjustment of the conditions per product, e.g. changing the minimum quantity for discounts or changing the discount given.

A protocol also allow for new condition types to be easily added by implementing the protocol.

An alternative could be to provide a single struct with the price conditions including a `type` field to indicate if it was buy-on-get-one-free, bulk discount etc.  This would probably involve less code, but would lead to unused struct fields, be less elegant and harder to extend.

### Representing money

In this simple example which only has a single currency we could use integers - e.g. £15.22 would be 1522.  However we do need to some division of the amount using non-integers (two thirds) and this library provides automatic rounding of amounts.

Additionally, although a basket would only be in one currency, it would allow for expansion if multiple currencies were involved, e.g a supermarket chain operating in multiple countries.

We could also use the `Decimal` library which is what `ex_money` uses internally.

