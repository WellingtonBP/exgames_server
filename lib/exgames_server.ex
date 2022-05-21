defmodule ExgamesServer do
  alias ExgamesServer.User

  defdelegate create_user(params), to: User.Create, as: :call
end
