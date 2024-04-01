defmodule InsiderTrading.Job do
  require Logger
  alias InsiderTradingWeb.InsiderTradeService

  def fetch_insider_trading_data() do
    Logger.info("Insider Trading: scheduled job for every minute -- Started...")

    InsiderTrading.Trading.has_company_with_incomplete_previous_year_data_fetch?()
    |> IO.inspect(label: ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
    |> fetch_insider_trading_info
  end

  def fetch_insider_trading_info(true) do
    InsiderTrading.Trading.company_for_historical_data_fetched()
    |> IO.inspect(label: ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
    |> InsiderTradeService.retrieve_and_store_insider_trades()
  end

  def fetch_insider_trading_info(false) do
    InsiderTrading.Trading.company_for_recent_data_fetched()
    |> Enum.each(fn company_info ->
      InsiderTradeService.retrieve_and_store_insider_trades(company_info)
    end)
  end

  def fetch_insider_trading_info(_), do: :no_op
end
