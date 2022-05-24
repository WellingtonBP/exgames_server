defmodule ExgamesServer.GameTest do
  use ExgamesServer.DataCase

  alias Ecto.UUID
  alias ExgamesServer.Game

  describe "changeset/2" do
    test "should return a valid changeset given valid params" do
      changeset =
        %Game{}
        |> Game.changeset(%{name: "tictac", creator: UUID.generate(), opponent: UUID.generate()})

      assert %Ecto.Changeset{valid?: true} = changeset
    end

    test "should return a invalid changeset given invalid params" do
      uuid = UUID.generate()

      changeset =
        %Game{}
        |> Game.changeset(%{creator: uuid, opponent: uuid})

      assert %Ecto.Changeset{valid?: false, errors: errors} = changeset
      assert errors[:name] == {"can't be blank", [validation: :required]}
      assert errors[:opponent] == {"can't be equal creator", []}
    end
  end
end
