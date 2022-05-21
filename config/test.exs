import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :exgames_server, ExgamesServer.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "exgames_server_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :exgames_server, ExgamesServerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "XO/7VPdlk/O2tVM3lJC4SU+Tl6EH8pDRXAt+HLWE0dbJC6kB0WGls3KTGCGYbJSh",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
