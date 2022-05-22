defmodule ExgamesServerWeb.Auth.ErrorHandler do
  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, _reason}, _opts) do
    %{errors: %{detail: to_string(type)}}
    |> Jason.encode!()
    |> then(fn body ->
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(401, body)
    end)
  end
end
