defmodule ExgamesServerWeb.AuthController do
  use ExgamesServerWeb, :controller

  alias ExgamesServerWeb.Auth.Guardian

  action_fallback ExgamesServerWeb.FallbackController

  def create(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> render("token.json", token: token)
    end
  end
end
