defmodule Mix.Tasks.SeedData do
  @moduledoc """
  This mix task loads seed data from list of seed files.
  """
  use Mix.Task
  alias InsiderTrading.Repo

  def run(_) do
    Mix.Task.run("app.start")

    company_info_seeds = [
      %{
        cik: 1_018_724,
        ticker: "AMZN",
        company_name: "AMAZON COM INC",
        availability_date: ~D[2023-06-01]
      },
      %{
        cik: 1_652_044,
        ticker: "GOOGL",
        company_name: "Alphabet Inc.",
        availability_date: ~D[2023-06-01]
      },
      %{
        cik: 1_326_801,
        ticker: "META",
        company_name: "Meta Platforms, Inc.",
        availability_date: ~D[2023-06-01]
      },
      %{
        cik: 320_193,
        ticker: "AAPL",
        company_name: "Apple Inc.",
        availability_date: ~D[2023-06-01]
      },
      %{
        cik: 1_045_810,
        ticker: "NVDA",
        company_name: "NVIDIA CORP.",
        availability_date: ~D[2023-06-01]
      },
      %{
        cik: 789_019,
        ticker: "MSFT",
        company_name: "Microsoft Corporation",
        availability_date: ~D[2023-06-01]
      }
    ]

    company_info_seeds
    |> Enum.each(fn seed ->
      schema = Repo.get_by(InsiderTrading.CompanyInfo, ticker: seed.ticker)
      if is_nil(schema) do
        Repo.insert!(InsiderTrading.CompanyInfo.changeset(%InsiderTrading.CompanyInfo{}, seed))
      end
    end)
  end
end
