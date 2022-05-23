defmodule ExgamesServer.User.Create do

  alias ExgamesServer.{Repo, User}

  def call(params) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert(response = {:ok, _}), do: response
  defp handle_insert({:error, changeset}), do: {:error, User.translate_errors(changeset)}
end
