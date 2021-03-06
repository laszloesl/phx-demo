defmodule Demo.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    clustering_topologies = Application.get_env(:libcluster, :topologies)

    children = [
      DemoWeb.Endpoint,
      Cluster.Supervisor.child_spec([clustering_topologies])
    ]

    opts = [strategy: :one_for_one, name: Demo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
