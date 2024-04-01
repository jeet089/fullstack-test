defmodule InsiderTrading.TradingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `InsiderTrading.Trading` context.
  """

  @doc """
  insert a company info.
  """
  def company_fixture(attrs \\ %{}) do
      InsiderTrading.Repo.insert!(
        InsiderTrading.CompanyInfo.changeset(%InsiderTrading.CompanyInfo{}, attrs)
      )
  end

  @doc """
  Generate a insider_trade.
  """
  def insider_trade_fixture(attrs \\ %{}) do
    {:ok, insider_trade} =
      attrs
      |> Enum.into(%{})
      |> InsiderTrading.Trading.create_insider_trade()

    insider_trade
  end
end
