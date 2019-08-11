# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :discuss,
  ecto_repos: [Discuss.Repo]

# Configures the endpoint
config :discuss, Discuss.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gAF8J0vspgBrlg3v0E9/6FwIwWP3o4N4nvJ1fOfiv1tBhJiclfpyPvtM12g7NvO6",
  render_errors: [view: Discuss.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Discuss.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :ueberauth, Ueberauth,
providers: [
  github: { Ueberauth.Strategy.Github, []}
]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
    client_id: "376f6f63f7ef48041920",
    client_secret: "cc46975d7e1cbeda0a0083303e29f6dbce0c8942"

    #f9e345c32515b64f543938130f14f3dae904b524
