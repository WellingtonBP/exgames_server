defmodule ExgamesServer.Game.Create do

  alias ExgamesServer.{Repo, Game}

  def call(creator, params) do
    creator
    |> Ecto.build_assoc(:games_created)
    |> Game.changeset(params)
    |> Repo.insert()
  end
end
