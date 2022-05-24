defmodule ExgamesServer.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string, null: false
      add :creator, references(:users, on_delete: :nothing, type: :uuid), null: false
      add :opponent, references(:users, on_delete: :nothing, type: :uuid), null: false
      add :winner, references(:users, on_delete: :nothing, type: :uuid)

      timestamps()
    end

    create index(:games, [:creator])
    create index(:games, [:opponent])
    create index(:games, [:winner])
  end
end
