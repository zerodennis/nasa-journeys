import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :nasa_journeys, NasaJourneys.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "nasa_journeys_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :nasa_journeys, NasaJourneysWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "5P2uIXf2fkpJ4NnFW9tWa7e4pKbJ17Cs7yStYvUzS4I1rQQeuzZuom4aA6uh6sKs",
  server: false

# In test we don't send emails.
config :nasa_journeys, NasaJourneys.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
