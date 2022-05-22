defmodule ExgamesServer.User.CreateTest do
  use ExgamesServer.DataCase

  alias ExgamesServer.User
  alias ExgamesServer.Repo

  describe "call/1" do
    test "should create a user and return {:ok, %User{}} given valid params" do
      before_count = Repo.aggregate(User, :count)

      response =
        %{name: "name", email: "valid@test.com", password: "abcd1234"}
        |> User.Create.call()

      after_count = Repo.aggregate(User, :count)

      assert {:ok, %User{name: "name", email: "valid@test.com"}} = response
      assert after_count > before_count
    end

    test "should return {:error, errors_map}} given invalid params" do
      before_count = Repo.aggregate(User, :count)

      response =
        %{name: "name", email: "invalid", password: "invalid"}
        |> User.Create.call()

      after_count = Repo.aggregate(User, :count)

      assert {:error,
              %{email: "invalid email format", password: "should be at least 8 character(s)"}} ==
               response

      assert after_count == before_count
    end
  end
end
