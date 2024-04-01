defmodule InsiderTradingWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use InsiderTradingWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: InsiderTradingWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: InsiderTradingWeb.ErrorHTML, json: InsiderTradingWeb.ErrorJSON)
    |> render(:"404")
  end

  def call(conn, {:error, [message]}) do
    conn
    |> put_status(:bad_request)
    |> put_view(html: InsiderTradingWeb.ErrorHTML, json: InsiderTradingWeb.ErrorJSON)
    |> render(:"400", %{message: message})
  end

  def call(conn, {:error, messages}) do
    conn
    |> put_status(:bad_request)
    |> put_view(html: InsiderTradingWeb.ErrorHTML, json: InsiderTradingWeb.ErrorJSON)
    |> render(:"400", %{message: messages})
  end

  def call(conn, {:query_error, cause}) do
    conn
    |> put_status(:internal_server_error)
    |> put_view(html: InsiderTradingWeb.ErrorHTML, json: InsiderTradingWeb.ErrorJSON)
    |> render(:"500", %{
      message: "Something went wrong with #{inspect(cause)} while querying to database"
    })
  end

  def call(conn, _) do
    conn
    |> put_status(:internal_server_error)
    |> put_view(html: InsiderTradingWeb.ErrorHTML, json: InsiderTradingWeb.ErrorJSON)
    |> render(:"500", %{message: "Something went wrong. Please try again"})
  end
end
