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
config :techdb, Techdb.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "S6Fr4j7WX+6mAdfahztTX9lmxwRCuMgAW46Eqdcd9ZTZNN2xLZ2u8SwPsY++qHNm",
  render_errors: [view: Techdb.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Techdb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
