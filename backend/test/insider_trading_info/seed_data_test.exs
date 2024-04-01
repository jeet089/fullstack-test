defmodule Mix.Tasks.AddSeedDataTest do
  use InsiderTrading.DataCase

  setup do
    Ecto.Adapters.SQL.Sandbox.checkout(InsiderTrading.Repo)
    {:ok, []}
  end

  test "adds seed data", %{} do
    assert :ok = Mix.Tasks.SeedData.run("")
  end
end
