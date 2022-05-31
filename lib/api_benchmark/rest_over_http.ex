defmodule ApiBenchmark.RestOverHttp do
  use Plug.Builder

  def child_spec(opts \\ Application.fetch_env!(:api_benchmark, __MODULE__)) do
    port = Keyword.get(opts, :port, 4004)

    Supervisor.child_spec(
      {Plug.Cowboy, scheme: :http, plug: __MODULE__, options: [port: port]},
      id: __MODULE__
    )
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    json_decoder: Jason

  def init(opts), do: opts

  def call(conn, opts) do
    %{params: msg} = conn = super(conn, opts)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(msg))
  end
end
