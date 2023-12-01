# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :cway,
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :cway, CwayWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: CwayWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Cway.PubSub,
  live_view: [signing_salt: "AuLue8w8"]

config :cway,
  producer_module: BroadwayRabbitMQ.Producer,
  producer_options: [
    queue: "numbers",
    declare: [durable: true],
    on_failure: :reject_and_requeue,
    qos: [
      prefetch_count: 50
    ],
    connection: [
      username: "guest",
      password: "guest"
    ],
    context: %{
      calculator_module: Cway.Calculator
    }
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.

import_config "#{config_env()}.exs"
