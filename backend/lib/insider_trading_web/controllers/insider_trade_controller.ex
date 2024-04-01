defmodule InsiderTradingWeb.InsiderTradeController do
  @moduledoc """
  The InsiderTradeController is responsible to serve to Insider Trade Info Request
  """
  use InsiderTradingWeb, :controller
  require Logger
  alias InsiderTradingWeb.InsiderTradeService
  action_fallback InsiderTradingWeb.FallbackController

  @doc """
  Render JSON response of list of Insider Trade Info for company by ticker
  """
  def index(conn, params) do
    with(
      :ok <- validate_insider_trade_req(params),
      {:result, trades} <- InsiderTradeService.get_insider_trades_by_ticker(params["ticker"]),
      {:ok, [%{market_cap: market_cap, price: share_price}]} <-
        InsiderTradeService.market_cap(params["ticker"]),
      {:ok, trades_with_market_cap} <-
        InsiderTradeService.add_market_cap_info(market_cap, share_price, trades)
    ) do
      render(conn, :index, insider_trades: trades_with_market_cap)
    end
  end

  @doc """
  Render JSON response of list of public companies stored in the database
  """
  def list_company(conn, _params) do
    with {:ok, companies} <- InsiderTradeService.get_company_list() do
      Logger.debug("Fetched Company List. Total Records Found: #{length(companies)}")
      render(conn, :list_company, companies: companies)
    end
  end

  defp validate_insider_trade_req(params) do
    schema = %{
      "ticker" => [:string, &validate_ticker/1, :required]
    }
    Skooma.valid?(params, schema)
  end

  defp validate_ticker(data) do
    if String.length(data) == 4 do
      :ok
    else
      {:error, "Invalid Ticker"}
    end
  end
end
