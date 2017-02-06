# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :techdb,
  ecto_repos: [Techdb.Repo]

# Configures the endpoint
config :techdb, Techdb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qSqFw17Mfdkll1AA1ZY9xzIPhrbwilBrFmZ3lad7qAxiHhwyXPGJ3CO+YaPi9hd2",
  render_errors: [view: Techdb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Techdb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :bolt_sips, Bolt,
  url: 'localhost:7687',
  basic_auth: [username: "neo4j", password: "tester"],
  pool_size: 5,
  max_overflow: 1

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
