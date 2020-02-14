import Config

config :demo, DemoWeb.Endpoint,
  check_origin: false,
  code_reloader: true,
  http: [port: 4000],
  pubsub: [name: Demo.PubSub, adapter: Phoenix.PubSub.PG2],
  secret_key_base: "sdHpQmq6Nu+XiA7mDUhoMA9gs0iEecxV/iGwJCu13J3dORzpZ1Mc/F9IF21LS2kH",
  url: [host: "localhost"],
  watchers: []

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :libcluster, :topologies,
  epmd: [
    strategy: Cluster.Strategy.Epmd,
    config: [
      hosts: [:"demo1@esl.localhost", :"demo2@esl.localhost"]
    ]
  ]

import_config "#{Mix.env()}.exs"
