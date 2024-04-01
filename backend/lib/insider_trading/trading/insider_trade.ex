defmodule InsiderTrading.InsiderTrade do
  use Ecto.Schema
  import Ecto.Changeset

  schema "insider_trades" do
    field :accession_number, :string
    field :share_qty, :integer
    field :transaction_date, :date
    field :transaction_code, :string
    field :transaction_price, :decimal
    field :job_title, :string
    field :person_name, :string
    field :filling_url, :string
    field :filling_date, :date

    belongs_to :company_info, InsiderTrading.CompanyInfo
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(insider_trade, attrs) do
    insider_trade
    |> cast(attrs, [
      :transaction_date,
      :accession_number,
      :share_qty,
      :transaction_code,
      :transaction_price,
      :job_title,
      :person_name,
      :filling_url,
      :filling_date,
      :company_info_id
    ])
    |> validate_required([
      :transaction_date,
      :accession_number,
      :share_qty,
      :transaction_code,
      :job_title,
      :person_name,
      :filling_url,
      :filling_date,
      :company_info_id
    ])
    |> cast_assoc(:company_info)
  end
end
