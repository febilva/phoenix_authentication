# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phoenix_authentication,
  ecto_repos: [PhoenixAuthentication.Repo]

# Configures the endpoint
config :phoenix_authentication, PhoenixAuthenticationWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WBizOec3pcMbDkotqJqnUd+xlvFMBVmO4xRISuJYVn5xJT/MQWG2iINz05aLCmip",
  render_errors: [view: PhoenixAuthenticationWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixAuthentication.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix_authentication, PhoenixAuthentication.Auth.Guardian,
  issuer: "phoenix_authentication",
  secret_key: "TM0VTDhdb9uy47lCNLkW6btdzwYGdnX1gTxoERzvDuUy1L23BmjZVnSHdIj9quOH"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
