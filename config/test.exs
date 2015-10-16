use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :fs_dev, FsDev.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :fs_dev, FsDev.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "",
  database: "fs_dev_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :admin_basic_auth, realm: "Admin Area", username: "admin", password: "secret"
