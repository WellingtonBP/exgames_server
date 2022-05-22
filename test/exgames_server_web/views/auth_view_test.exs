defmodule ExgamesServerWeb.AuthViewTest do
  use ExgamesServerWeb.ConnCase, async: true

  import Phoenix.View

  test "renders token.json" do
    assert render(ExgamesServerWeb.AuthView, "token.json", token: "sometoken") == %{
             token: "sometoken"
           }
  end
end
