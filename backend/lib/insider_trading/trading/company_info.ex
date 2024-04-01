defmodule InsiderTrading.CompanyInfo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "company_info" do
    field :cik, :integer
    field :ticker, :string
    field :historical_data_fetched, :boolean
    field :company_name, :string
    field :availability_date, :date
    has_many :insider_trades, InsiderTrading.InsiderTrade
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(company_info, attrs) do
    company_info
    |> cast(attrs, [
      :cik,
      :ticker,
      :company_name,
      :availability_date,
      :historical_data_fetched
    ])
    |> validate_required([:cik, :ticker, :company_name, :availability_date])
  end
end
