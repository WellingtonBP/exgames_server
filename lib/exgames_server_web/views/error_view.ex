defmodule ExgamesServerWeb.ErrorView do
  use ExgamesServerWeb, :view

  def render("errors.json", %{errors: errors}) do
    %{errors: errors}
  end

  def render("404.json", _assigns) do
    %{errors: %{detail: "not found"}}
  end

  def render("500.json", _assigns) do
    %{errors: %{detail: "internal server error"}}
  end
end
