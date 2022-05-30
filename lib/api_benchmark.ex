defmodule ApiBenchmark do
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    children = [
      {Task.Supervisor, name: ApiBenchmark.Tcp.Supervisor},
      ApiBenchmark.Tcp,
      ApiBenchmark.Udp,
    ]

    Logger.info("Application started")

    opts = [strategy: :one_for_one, name: ApiBenchmark.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
