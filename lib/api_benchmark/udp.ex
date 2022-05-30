defmodule ApiBenchmark.Udp do
  require Logger

  @default_port 4001
  @default_opts [:binary, active: false]

  def child_spec(opts \\ Application.fetch_env!(:api_benchmark, :udp)) do
    Supervisor.child_spec(
      {Task, fn -> accept(opts) end},
      id: __MODULE__,
      restart: :permanent
    )
  end

  def accept(opts \\ []) do
    port = Keyword.get(opts, :port, @default_port)
    opts = Keyword.get(opts, :gen_udp_opts, @default_opts)

    {:ok, socket} = :gen_udp.open(port, opts)

    Logger.info("Accepting udp connection on #{port}")

    serve(socket)
  end

  defp serve(socket) do
    socket
    |> read()
    |> write(socket)

    serve(socket)
  end

  defp read(socket) do
    {:ok, data} = :gen_udp.recv(socket, 0)
    data
  end

  defp write({addr, port, msg}, socket) do
    :gen_udp.send(socket, addr, port, msg)
  end
end
