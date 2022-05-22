defmodule ExgamesServerWeb.Auth.GuardianTest do
  use ExgamesServerWeb.ConnCase, async: true

  alias ExgamesServer.UserFixture
  alias ExgamesServerWeb.Auth.Guardian

  describe "authenticate/1" do
    test "should return token tuple given valid params" do
      user = UserFixture.create_user()

      assert {:ok, token} =
               Guardian.authenticate(%{
                 "email" => user.email,
                 "password" => UserFixture.get_password()
               })

      assert {:ok, %{"sub" => id}} = Guardian.decode_and_verify(token)
      assert user.id == id
    end

    test "should return error tuple given invalid params" do
      assert {:error, :invalid_params} = Guardian.authenticate(%{})
    end

    test "should return error tuple given nonexistent user" do
      assert {:error, :user_not_found} =
               Guardian.authenticate(%{
                 "email" => "nonexistent@email.com",
                 "password" => "somepass"
               })
    end

    test "should return error tuple given invalid password" do
      user = UserFixture.create_user()

      assert {:error, :invalid_password} =
               Guardian.authenticate(%{"email" => user.email, "password" => "invalidpass"})
    end
  end
end
