defmodule ExgamesServer.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false
      add :email, :string, null: false
      add :avatar_url, :string
      add :birthday, :date
      add :hashed_password, :string

      timestamps()
    end

    create unique_index(:users, [:name])
    create unique_index(:users, [:email])
  end
end
