defmodule ExgamesServerWeb.Plugs.FileUpload do
  import Plug.Conn

  def init(params), do: params

  def call(conn = %Plug.Conn{params: params}, _opts) do
    params
    |> Map.get("avatar_file")
    |> handle_file(conn)
  end

  defp handle_file(file = %Plug.Upload{content_type: "image/" <> _}, conn) do
    file
    |> save_file()
    |> then(fn path ->
      conn.params
      |> put_in(Map.put(conn.params, "avatar_url", "api/uploads/#{Path.basename(path)}"))
    end)
  end

  defp handle_file(%Plug.Upload{}, conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(422, Jason.encode!(%{errors: %{avatar_file: "invalid file format"}}))
    |> halt()
  end

  defp handle_file(_, conn), do: conn

  defp save_file(file) do
    file.filename
    |> generate_path()
    |> tap(&File.cp(file.path, &1))
  end

  defp generate_path(filename) do
    Application.get_env(:exgames_server, :upload_path)
    |> Kernel.<>("/#{get_current_date()}")
    |> Kernel.<>(filename)
  end

  defp get_current_date do
    DateTime.utc_now()
    |> DateTime.to_unix()
  end
end
