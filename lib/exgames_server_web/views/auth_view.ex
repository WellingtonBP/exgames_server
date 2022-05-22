defmodule ExgamesServerWeb.AuthView do
  use ExgamesServerWeb, :view

  def render("token.json", %{token: token}) do
    %{token: token}
  end
end
