defmodule InsiderTrading.Trading do
  @moduledoc """
  The Trading context is to fetch information of different entity from the database
  """

  import Ecto.Query, warn: false
  alias InsiderTrading.Repo

  alias InsiderTrading.InsiderTrade
  alias InsiderTrading.CompanyInfo

  @doc """
  Gets a single insider_trade.

  Raises `Ecto.NoResultsError` if the Insider trade does not exist.

  ## Examples

      iex> get_insider_trade!(123)
      %InsiderTrade{}

      iex> get_insider_trade!(456)
      ** (Ecto.NoResultsError)

  """
  def get_insider_trade!(id), do: Repo.get!(InsiderTrade, id)

  @doc """
  Creates a insider_trade.

  ## Examples

      iex> create_insider_trade(%{field: value})
      {:ok, %InsiderTrade{}}

      iex> create_insider_trade(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_insider_trade(attrs \\ %{}) do
    %InsiderTrade{}
    |> InsiderTrade.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a insider_trade.

  ## Examples

      iex> update_insider_trade(insider_trade, %{field: new_value})
      {:ok, %InsiderTrade{}}

      iex> update_insider_trade(insider_trade, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_insider_trade(%InsiderTrade{} = insider_trade, attrs) do
    insider_trade
    |> InsiderTrade.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a insider_trade.

  ## Examples

      iex> delete_insider_trade(insider_trade)
      {:ok, %InsiderTrade{}}

      iex> delete_insider_trade(insider_trade)
      {:error, %Ecto.Changeset{}}

  """
  def delete_insider_trade(%InsiderTrade{} = insider_trade) do
    Repo.delete(insider_trade)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking insider_trade changes.

  ## Examples

      iex> change_insider_trade(insider_trade)
      %Ecto.Changeset{data: %InsiderTrade{}}

  """
  def change_insider_trade(%InsiderTrade{} = insider_trade, attrs \\ %{}) do
    InsiderTrade.changeset(insider_trade, attrs)
  end

  def get_insider_trade_info_by_ticker(ticker) do
    comapany_info =
      CompanyInfo
      |> where([cm], cm.ticker == ^ticker)
      |> Repo.one()
      |> Repo.preload(insider_trades: from(it in InsiderTrade, order_by: [desc: it.filling_date]))

    {:ok, comapany_info.insider_trades}
  end

  def company_list() do
    companies =
      CompanyInfo
      |> order_by(asc: :id)
      |> Repo.all()

    {:ok, companies}
  end

  def company_for_historical_data_fetched() do
    CompanyInfo
    |> where([ci], ci.historical_data_fetched == false)
    |> order_by(asc: :id)
    |> limit(1)
    |> Repo.one()
    |> Repo.preload(insider_trades: from(it in InsiderTrade, order_by: [asc: it.filling_date]))
  end

  def company_for_recent_data_fetched() do
    CompanyInfo
    |> where([ci], ci.historical_data_fetched == true)
    |> order_by(asc: :id)
    |> Repo.all()
    |> Repo.preload(insider_trades: from(it in InsiderTrade, order_by: [asc: it.filling_date]))
  end

  def has_company_with_incomplete_previous_year_data_fetch?() do
    CompanyInfo
    |> where([ci], ci.historical_data_fetched == false)
    |> IO.inspect(label: ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
    |> Repo.exists?()
  end

  def update_company_info(%CompanyInfo{} = company_info, attrs) do
    company_info
    |> CompanyInfo.changeset(attrs)
    |> Repo.update()
  end
end
