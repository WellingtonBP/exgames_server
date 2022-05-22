defmodule ExgamesServerWeb.Router do
  use ExgamesServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug ExgamesServerWeb.Auth.Pipeline
  end

  scope "/api", ExgamesServerWeb do
    pipe_through :api

    resources "/users", UserController, only: [:create]
    resources "/users/auth", AuthController, only: [:create]
  end
end
