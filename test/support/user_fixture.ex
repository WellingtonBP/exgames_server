defmodule ExgamesServer.UserFixture do
  alias ExgamesServer.User.Create

  def create_user do
    %{name: "user", email: "valid@email.com", password: "abcd1234"}
    |> Create.call()
    |> elem(1)
  end

  def get_password, do: "abcd1234"

  def create_secondary_user do
    %{name: "user2", email: "valid2@email.com", password: "abcd1234"}
    |> Create.call()
    |> elem(1)
  end
end
