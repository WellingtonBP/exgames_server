defmodule ExgamesServerWeb.FallbackController do
  use ExgamesServerWeb, :controller

  alias ExgamesServerWeb.ErrorView

  def call(conn, {:error, errors}) do
    conn
    |> put_status(422)
    |> put_view(ErrorView)
    |> render("errors.json", errors: errors)
  end
end
