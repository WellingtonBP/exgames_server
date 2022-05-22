defmodule ExgamesServerWeb.UserControllerTest do
  use ExgamesServerWeb.ConnCase

  describe "create/2" do
    setup %{conn: conn} do
      {:ok, conn: put_req_header(conn, "accept", "application/json")}
    end

    test "should return the created user and status 200 given valid body", %{conn: conn} do
      conn =
        %{name: "valid", email: "valid@email.com", password: "abcd1234"}
        |> then(&post(conn, Routes.user_path(conn, :create), &1))

      assert %{"name" => "valid", "email" => "valid@email.com"} = json_response(conn, 200)
    end

    test "should return errors and status 422 given invalid body", %{conn: conn} do
      conn =
        %{email: "invalid", password: "invalid"}
        |> then(&post(conn, Routes.user_path(conn, :create), &1))

      assert %{
               "errors" => %{
                 "name" => "can't be blank",
                 "email" => "invalid email format",
                 "password" => "should be at least 8 character(s)"
               }
             } == json_response(conn, 422)
    end
  end
end
