# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :insider_trading,
  ecto_repos: [InsiderTrading.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :insider_trading, InsiderTradingWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: InsiderTradingWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: InsiderTrading.PubSub,
  live_view: [signing_salt: "s4Ns3dqh"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :insider_trading, InsiderTrading.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# EDGAR APIs Config
config :insider_trading,
  headers: [
    {"User-Agent", "insider-trading-info/1.0.0"},
    {"Accept", "*/*"}
  ]

config :insider_trading, InsiderTrading.Scheduler,
  jobs: [
    # Every minute
    { System.get_env("INSIDER_TRADING_INTERVAL") || "* * * * *", {InsiderTrading.Job, :fetch_insider_trading_data, []}},
  ]

config :insider_trading,
  edgar_url_template:
    "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=%k&type=4&company=&dateb=%b&datea=%a&owner=include&start=%s&count=%c&output=atom"

config :insider_trading,
  market_cap_url_template:
    "https://query2.finance.yahoo.com/v10/finance/quoteSummary/?symbol=%t&modules=summaryDetail"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
