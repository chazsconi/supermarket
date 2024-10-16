# Supermarket

Programming challenge.

## Setup

Run `mix deps.get`

## Run tests

Run `mix test`

## Design choices

### Special Price Conditions

These are implemented using a protocol thus allowing easy adjustment of the conditions per product, e.g. changing the minimum quantity for discounts or changing the discount given.

A protocol also allows for new condition types to be easily added with a new struct that implements the protocol.

An alternative could be to provide a single struct with the price conditions including a `type` field to indicate if it was buy-on-get-one-free, bulk discount etc.  This would probably involve less code, but would lead to unused struct fields, be less elegant and harder to extend.

### Representing money

The `ex_money` library is used for this.  

In this simple example which only has a single currency we could use integers - e.g. £15.22 would be 1522.  However we do need to some division of the amount using non-integers (e.g. two thirds) and the `ex_money` library provides functions for rounding and normalising amounts.

Additionally, although a basket would only be in one currency, using `ex_money` would allow for future expansion if multiple currencies were involved, e.g a supermarket chain operating in multiple countries.

Another alternative would be to use the `Decimal` library which is what `ex_money` uses internally.

### Configuration

The product and price configuration are built using the `Products` module and passed to the `Checkout.cashier/2` function as a 2nd parameter.  As `Checkout.cashier/2` is a pure function, it allows for easy testing as different product configurations can be used for different tests.

An alternative (which I tried initially and then refactored) would be to set the product and price configuration in the config. (Probably using `runtime.exs` instead of other config files to allow using structs).  This would mean that `Checkout.cashier` would just take a single argument of a list of product codes - the products and price configuration would be fetched from the config in the `Checkout` module functions. However, testing would be harder.

In a real system the product list would probably come from a DB and then could be deserialised to structs (e.g. using `Ecto`) and optimised by caching in memory.
