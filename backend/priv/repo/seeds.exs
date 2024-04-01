# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#

company_info_seeds = [
  %{
    cik: 320_193,
    ticker: "AAPL",
    company_name: "Apple Inc.",
    availability_date: ~D[2023-01-01]
  },
  %{
    cik: 1_045_810,
    ticker: "NVDA",
    company_name: "NVIDIA CORP.",
    availability_date: ~D[2023-01-01]
  },
  %{
    cik: 789_019,
    ticker: "MSFT",
    company_name: "Microsoft Corporation",
    availability_date: ~D[2023-01-01]
  }
]

# Insert seed data into the database
Enum.each(company_info_seeds, fn seed ->
  InsiderTrading.Repo.insert!(
    InsiderTrading.CompanyInfo.changeset(%InsiderTrading.CompanyInfo{}, seed)
  )
end)
