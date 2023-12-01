defmodule Cway.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CwayWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:cway, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Cway.PubSub},
      {NumbersPipeline,
       [
         producer_module: Application.get_env(:cway, :producer_module),
         producer_options: Application.get_env(:cway, :producer_options),
         calculator_module: Application.get_env(:cway, :calculator_module)
       ]},

      # Start a worker by calling: Cway.Worker.start_link(arg)
      # {Cway.Worker, arg},
      # Start to serve requests, typically the last entry
      CwayWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Cway.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CwayWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
