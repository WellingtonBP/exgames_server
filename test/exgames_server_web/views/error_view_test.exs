defmodule ExgamesServerWeb.ErrorViewTest do
  use ExgamesServerWeb.ConnCase, async: true

  import Phoenix.View

  test "renders 404.json" do
    assert render(ExgamesServerWeb.ErrorView, "404.json", []) == %{errors: %{detail: "not found"}}
  end

  test "renders 500.json" do
    assert render(ExgamesServerWeb.ErrorView, "500.json", []) ==
             %{errors: %{detail: "internal server error"}}
  end

  test "renders errors.json" do
    assert render(ExgamesServerWeb.ErrorView, "errors.json", errors: %{detail: "test error"}) ==
             %{errors: %{detail: "test error"}}
  end
end
