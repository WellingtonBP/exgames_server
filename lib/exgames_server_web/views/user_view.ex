defmodule ExgamesServerWeb.UserView do
  use ExgamesServerWeb, :view

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      name: user.name,
      avatar_url: user.avatar_url,
      birthday: user.birthday,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end
end
