defmodule InsiderTradingWeb.InsiderTradeJSON do
  alias InsiderTrading.CompanyInfo

  @doc """
  Renders a list of insider_trades.
  """
  def index(%{insider_trades: insider_trades}) do
    %{data: for(insider_trade <- insider_trades, do: trade_data(insider_trade))}
  end

  @doc """
  Renders a single insider_trade.
  """
  def show(%{insider_trade: insider_trade}) do
    %{
      company_name: insider_trade.company_name,
      data: for(trade <- insider_trade.insider_trades, do: trade_data(trade))
    }
  end

  @doc """
  Renders a list of companies.
  """
  def list_company(%{companies: companies}) do
    %{
      data: for(company <- companies, do: company_data(company))
    }
  end


  defp company_data(%CompanyInfo{} = company) do
    %{
      company_name: company.company_name,
      ticker: company.ticker
    }
  end


  defp trade_data(%{} = trade) do
    trade
  end
end
