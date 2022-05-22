defmodule ExgamesServerWeb.FallbackController do
  use ExgamesServerWeb, :controller

  alias ExgamesServerWeb.ErrorView

  def call(conn, {:error, :invalid_params}) do
    conn
    |> put_status(422)
    |> put_view(ErrorView)
    |> render("errors.json", errors: %{detail: "invalid params"})
  end

  def call(conn, {:error, :user_not_found}) do
    conn
    |> put_status(404)
    |> put_view(ErrorView)
    |> render("errors.json", errors: %{detail: "user not found"})
  end

  def call(conn, {:error, :invalid_password}) do
    conn
    |> put_status(401)
    |> put_view(ErrorView)
    |> render("errors.json", errors: %{detail: "invalid password"})
  end

  def call(conn, {:error, errors}) do
    conn
    |> put_status(422)
    |> put_view(ErrorView)
    |> render("errors.json", errors: errors)
  end
end
