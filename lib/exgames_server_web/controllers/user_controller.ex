defmodule ExgamesServerWeb.UserController do
  use ExgamesServerWeb, :controller

  alias ExgamesServer

  plug ExgamesServerWeb.Plugs.FileUpload, "en" when action in [:create]

  action_fallback ExgamesServerWeb.FallbackController

  def create(conn, params) do
    with {:ok, user} <- ExgamesServer.create_user(params) do
      conn
      |> render("user.json", user: user)
    end
  end
end
