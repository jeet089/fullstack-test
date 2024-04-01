defmodule InsiderTrading.TradingTest do
  use InsiderTrading.DataCase

  alias InsiderTrading.Trading

  describe "insider_trades" do
    alias InsiderTrading.Trading

    @historical_data %{
      cik: 1_018_724,
      ticker: "AMZN",
      company_name: "AMAZON COM INC",
      availability_date: ~D[2024-03-25],
      historical_data_fetched: false
    }

    @recent_data %{
      cik: 1_018_724,
      ticker: "AMZN",
      company_name: "AMAZON COM INC",
      availability_date: ~D[2024-03-25],
      historical_data_fetched: true
    }

    test "list_company_info returns all" do
      company_created = InsiderTrading.TradingFixtures.company_fixture(@historical_data)
      {:ok, company_list} = Trading.company_list()
      assert company_list == [company_created]
    end

    test "get_historical_insider_trading" do
      company_created = InsiderTrading.TradingFixtures.company_fixture(@historical_data)

      {:success, data} =
        company_created.historical_data_fetched
        |> InsiderTrading.Job.fetch_insider_trading_info()

      {:ok, list} =
        InsiderTrading.Trading.get_insider_trade_info_by_ticker(company_created.ticker)

      assert data |> Enum.count() == list |> Enum.count()
    end

    test "get_recent_insider_trading" do
      company_created = InsiderTrading.TradingFixtures.company_fixture(@recent_data)

      assert :ok ==
               company_created.historical_data_fetched
               |> InsiderTrading.Job.fetch_insider_trading_info()
    end
  end
end
