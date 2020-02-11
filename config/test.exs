use Mix.Config

config :demo, DemoWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
