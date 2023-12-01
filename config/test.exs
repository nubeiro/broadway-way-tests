import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :cway, CwayWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "/ueSHkI6NEvzSNtcuDuFKnAy0aRC3JXe/f8ZndpAEvAqD3+F0mAYMHLW3pklc3P9",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :cway,
  producer_module: Broadway.DummyProducer,
  producer_options: [],
  calculator_module: Cway.CalculatorMock
