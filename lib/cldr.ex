defmodule Supermarket.Cldr do
  @moduledoc "CLDR configuration for project.  Needed for ex_money."
  use Cldr,
    locales: ["en"],
    default_locale: "en",
    providers: [Cldr.Number, Money]
end
