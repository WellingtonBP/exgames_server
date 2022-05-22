defmodule ExgamesServerWeb.AuthControllerTest do
  use ExgamesServerWeb.ConnCase, async: true

  alias ExgamesServer.UserFixture
  alias ExgamesServerWeb.Auth.Guardian

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create/2" do
    test "should return a token given valid email and password", %{conn: conn} do
      user = UserFixture.create_user()

      conn =
        %{email: user.email, password: UserFixture.get_password()}
        |> then(&post(conn, Routes.auth_path(conn, :create), &1))

      assert %{"token" => token} = json_response(conn, 200)
      assert {:ok, %{"sub" => id}} = Guardian.decode_and_verify(token)
      assert id == user.id
    end

    test "should return error given invalid params", %{conn: conn} do
      conn =
        %{}
        |> then(&post(conn, Routes.auth_path(conn, :create), &1))

      assert %{"errors" => %{"detail" => "invalid params"}} = json_response(conn, 422)
    end

    test "should return error given nonexistent user", %{conn: conn} do
      conn =
        %{email: "nonexistent@email.com", password: "somepass"}
        |> then(&post(conn, Routes.auth_path(conn, :create), &1))

      assert %{"errors" => %{"detail" => "user not found"}} = json_response(conn, 404)
    end

    test "should return error given invalid password", %{conn: conn} do
      user = UserFixture.create_user()

      conn =
        %{email: user.email, password: "invalid"}
        |> then(&post(conn, Routes.auth_path(conn, :create), &1))

      assert %{"errors" => %{"detail" => "invalid password"}} = json_response(conn, 401)
    end
  end
end
