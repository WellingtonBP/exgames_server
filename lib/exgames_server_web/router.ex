defmodule ExgamesServerWeb.Router do
  use ExgamesServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExgamesServerWeb do
    pipe_through :api

    resources "/users", UserController, only: [:create]
  end
end
