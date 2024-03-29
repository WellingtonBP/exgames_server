# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :exgames_server,
  ecto_repos: [ExgamesServer.Repo]

# Configures upload path
config :exgames_server, upload_path: "#{File.cwd!()}/priv/static/uploads"

# Configures guardian jwt secret key and pipeline
config :exgames_server, ExgamesServerWeb.Auth.Guardian,
  issuer: "exgames_server",
  secret_key: System.get_env("JWT_SECRET") || "unsafe_jwt_secret"

config :exgames_server, ExgamesServerWeb.Auth.Pipeline,
  module: ExgamesServerWeb.Auth.Guardian,
  error_handler: ExgamesServerWeb.Auth.ErrorHandler

# Configures the endpoint
config :exgames_server, ExgamesServerWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ExgamesServerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ExgamesServer.PubSub,
  live_view: [signing_salt: "MgJBMA7C"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
