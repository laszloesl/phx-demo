import Config

config :demo, DemoWeb.Endpoint,
  http: [port: 4000],
  url: [host: "localhost"],
  secret_key_base: "sdHpQmq6Nu+XiA7mDUhoMA9gs0iEecxV/iGwJCu13J3dORzpZ1Mc/F9IF21LS2kH",
  pubsub: [name: Demo.PubSub, adapter: Phoenix.PubSub.PG2],
  code_reloader: true,
  check_origin: false,
  watchers: []

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
