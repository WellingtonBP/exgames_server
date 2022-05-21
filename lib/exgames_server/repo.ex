defmodule ExgamesServer.Repo do
  use Ecto.Repo,
    otp_app: :exgames_server,
    adapter: Ecto.Adapters.Postgres
end
