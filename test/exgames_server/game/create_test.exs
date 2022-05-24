defmodule ExgamesServer.Game.CreateTest do
  use ExgamesServer.DataCase

  alias ExgamesServer.{Game, UserFixture}

  describe "call/2" do
    test "should create a game and return game data given valid params" do
      game =
        UserFixture.create_user()
        |> Game.Create.call(%{name: "tictac", opponent: UserFixture.create_secondary_user().id})

      assert {:ok, %Game{}} = game
    end

    test "should return a changeset with errors given invalid params" do
      user = UserFixture.create_user()

      game =
        user
        |> Game.Create.call(%{opponent: user.id})

      assert {:error, %Ecto.Changeset{valid?: false}} = game
    end
  end
end
