# Supermarket

Programming challenge.

## Setup

Run `mix deps.get`

## Run tests

Run `mix test`

## Design choices

### Configuration

The product and price configuration is set in `runtime.exs` thus allowing us to use structs (which wouldn't be possible in other config files).

An alternative would be to remove the products list from the config and pass it as a 2nd parameter in `Checkout.cashier/1`.

In a real system the product list would probably come from a DB and then could be deserialised to structs (e.g. using `Ecto`) and optimised by caching in memory.

### Special Price Conditions

These are implemented using a protocol thus allowing easy adjustment of the conditions per product, e.g. changing the minimum quantity for discounts or changing the discount given.

A protocol also allow for new condition types to be easily added by implementing the protocol.

An alternative could be to provide a single struct with the price conditions including a `type` field to indicate if it was buy-on-get-one-free, bulk discount etc.  This would probably involve less coe, but would lead to unused struct fields and be less elegant.

### Representing money

In this simple example which only has a single currency we could use integers - e.g. £15.22 would be 1522.  However we do need to some division of the amount using non-integers (two thirds) and this library provides automatic rounding of amounts.

Additionally, although a basket would only be in one currency, it would allow for expansion if multiple currencies were involved, e.g a supermarket chain operating in multiple countries.

We could also use the `Decimal` library which is what `ex_money` uses internally.
