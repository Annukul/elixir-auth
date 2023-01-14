defmodule HelloApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      HelloApi.Repo,
      # Start the Telemetry supervisor
      HelloApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: HelloApi.PubSub},
      # Start the Endpoint (http/https)
      HelloApiWeb.Endpoint
      # Start a worker by calling: HelloApi.Worker.start_link(arg)
      # {HelloApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HelloApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
