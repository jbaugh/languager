use Mix.Config

# Configure your database
config :languager, Languager.Repo,
  username: "languager",
  password: "123123",
  database: "languager_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :languager, LanguagerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
