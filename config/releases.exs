import Config

config :demo, DemoWeb.Endpoint,
  http: [port: String.to_integer(System.fetch_env!("PORT"))],
  url: [host: System.get_env("HOST", "localhost")],
  secret_key_base: System.fetch_env!("SECRET_KEY_BASE")
