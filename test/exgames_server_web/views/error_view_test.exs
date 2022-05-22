defmodule ExgamesServerWeb.ErrorViewTest do
  use ExgamesServerWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.json" do
    assert render(ExgamesServerWeb.ErrorView, "404.json", []) == %{errors: %{detail: "not found"}}
  end

  test "renders 500.json" do
    assert render(ExgamesServerWeb.ErrorView, "500.json", []) ==
             %{errors: %{detail: "internal server error"}}
  end
end
