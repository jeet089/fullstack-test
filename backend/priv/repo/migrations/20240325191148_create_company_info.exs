defmodule Trading.Repo.Migrations.CreateCompanyMasterInfo do
  use Ecto.Migration

  def change do
    create table(:company_info) do
      add :cik, :integer
      add :historical_data_fetched, :boolean, default: false
      add :ticker, :string
      add :company_name, :string
      add :availability_date, :date
      timestamps(type: :utc_datetime)
    end
  end
end
