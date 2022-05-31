defmodule ApiBenchmark.Tcp do
  require Logger

  @default_port 4000
  @default_opts [:binary, packet: :line, active: false, reuseaddr: true]

  def child_spec(opts \\ Application.fetch_env!(:api_benchmark, __MODULE__)) do
    Supervisor.child_spec(
      {Task, fn -> accept(opts) end},
      id: __MODULE__,
      restart: :permanent
    )
  end

  def accept(opts) do
    port = Keyword.get(opts, :port, @default_port)
    opts = Keyword.get(opts, :gen_tcp_opts, @default_opts)

    {:ok, socket} = :gen_tcp.listen(port, opts)
    Logger.info("Accepting tcp connections on #{port}")

    loop_acceptor(socket)
  end

  defp loop_acceptor(socket) do
    Logger.debug(":gen_tcp.accept on #{inspect socket}")
    {:ok, client} = :gen_tcp.accept(socket)
    {:ok, pid} = Task.Supervisor.start_child(ApiBenchmark.Tcp.Supervisor, fn -> serve(client) end)
    :ok = :gen_tcp.controlling_process(client, pid)
    loop_acceptor(socket)
  end

  defp serve(socket) do
    socket
    |> read_line()
    |> write_line(socket)

    serve(socket)
  end

  defp read_line(socket) do
    Logger.debug(":gen_tcp.recv on #{inspect socket}")
    {:ok, data} = :gen_tcp.recv(socket, 0)
    data
  end

  defp write_line(line, socket) do
    Logger.debug(":gen_tcp.send on #{inspect socket}")
    :gen_tcp.send(socket, line)
  end
end
