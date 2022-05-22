defmodule ExgamesServerWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :exgames_server

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
