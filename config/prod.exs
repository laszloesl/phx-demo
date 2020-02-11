import Config

config :logger, level: :info

config :demo, DemoWeb.Endpoint,
  server: true,
  code_reloader: false,
  check_origin: true

config :libcluster, :topologies,
  k8s: [
    strategy: Elixir.Cluster.Strategy.Kubernetes.DNS,
    config: [
      service: "demo-service",
      kubernetes_selector: "app=demo",
      application_name: "demo"
    ]
  ]
