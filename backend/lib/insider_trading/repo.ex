defmodule InsiderTrading.Repo do
  use Ecto.Repo,
    otp_app: :insider_trading,
    adapter: Ecto.Adapters.Postgres
end
