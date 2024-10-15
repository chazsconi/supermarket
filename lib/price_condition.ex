defprotocol Supermarket.PriceCondition do
  @moduledoc """
  Protocol that special price conditions must implement
  """

  @doc """
  Calculates the total price

  ## Arguments
  * `condition` - The `condition` module
  * `base_price` - A base price `Money` struct
  * `quantity` - Count of items at this price

  """
  def total_price(condition, base_price, quantity)
end
