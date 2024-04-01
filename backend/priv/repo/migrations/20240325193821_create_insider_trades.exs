defmodule Trading.Repo.Migrations.CreateInsiderTradeInfo do
  use Ecto.Migration

  def change do
    create table(:insider_trades) do
      add :transaction_date, :date
      add :accession_number, :string
      add :share_qty, :integer
      add :transaction_code, :string
      add :transaction_price, :decimal, null: true
      add :job_title, :string
      add :person_name, :string
      add :filling_date, :date
      add :filling_url, :string

      # Foreign key reference to company_info table
      add :company_info_id, references(:company_info, on_delete: :delete_all)
      timestamps(type: :utc_datetime)
    end

    create index(:insider_trades, [:company_info_id])
  end
end
