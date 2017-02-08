use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :techdb, Techdb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :techdb, Techdb.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "techdb_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :bolt_sips, Bolt,
  url: 'localhost:7687',
  basic_auth: [username: "neo4j", password: "tester"],
  pool_size: 5,
  max_overflow: 1
