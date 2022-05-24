defmodule ExgamesServer.Game do
  use Ecto.Schema
  import Ecto.Changeset

  alias ExgamesServer.User

  schema "games" do
    field :name, :string

    belongs_to :user_creator, User, foreign_key: :creator, type: Ecto.UUID
    belongs_to :user_opponent, User, foreign_key: :opponent, type: Ecto.UUID
    belongs_to :user_winner, User, foreign_key: :winner, type: Ecto.UUID

    timestamps()
  end

  def changeset(game, attrs) do
    game
    |> cast(attrs, [:name, :creator, :opponent, :winner])
    |> validate_required([:name, :creator, :opponent])
    |> check_opponent()
  end

  defp check_opponent(changeset) do
    creator =
      changeset
      |> get_creator()

    changeset
    |> validate_change(:opponent, fn :opponent, opponent ->
      case opponent do
        ^creator ->
          [opponent: "can't be equal creator"]

        _ ->
          []
      end
    end)
  end

  defp get_creator(changeset) do
    case get_field(changeset, :creator) do
      nil ->
        get_change(changeset, :creator)

      creator ->
        creator
    end
  end
end
