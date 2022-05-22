defmodule ExgamesServer.UserTest do
  use ExgamesServer.DataCase

  alias ExgamesServer.User

  describe "changeset/2" do
    test "should return a valid changeset given valid params" do
      changeset =
        %User{}
        |> User.changeset(%{name: "valid", email: "email@test.com", password: "abcd1234"})

      assert %Ecto.Changeset{valid?: true} = changeset
    end

    test "should return a invalid changeset given invalid params" do
      changeset =
        %User{}
        |> User.changeset(%{name: "valid", email: "invalidemail", password: "abcd1234"})

      assert %Ecto.Changeset{valid?: false} = changeset
      assert errors_on(changeset) == %{email: ["invalid email format"]}
    end
  end

  describe "translate_errors/1" do
    test "should return nil given a valid changeset" do
      errors =
        %User{}
        |> User.changeset(%{name: "valid", email: "email@test.com", password: "abcd1234"})
        |> User.translate_errors()

      assert errors == nil
    end

    test "should return errors translated given a invalid changeset" do
      errors =
        %User{}
        |> User.changeset(%{email: "invalidemail", password: "invalid"})
        |> User.translate_errors()

      assert errors == %{
               name: "can't be blank",
               email: "invalid email format",
               password: "should be at least 8 character(s)"
             }
    end
  end
end
