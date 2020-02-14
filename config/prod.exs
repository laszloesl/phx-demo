import Config

config :logger, level: :info

config :demo, DemoWeb.Endpoint,
  server: true,
  code_reloader: false,
  check_origin: true
