defmodule ApiBenchmark.Grpc do
  use GRPC.Endpoint

  intercept GRPC.Logger.Server
  run __MODULE__.Server

  def child_spec(opts \\ Application.fetch_env!(:api_benchmark, :grpc)) do
    port = Keyword.get(opts, :port, 4002)

    Supervisor.child_spec(
      {GRPC.Server.Supervisor, {__MODULE__, port}},
      id: __MODULE__
    )
  end

  defmodule Server do
    alias ApiBenchmark.Protos
    use GRPC.Server, service: Protos.EchoService.Service

    @spec echo(Protos.EchoRequest.t(), GRPC.Server.Stream.t()) :: Protos.EchoResponse.t()
    def echo(request, _stream) do
      Protos.EchoResponse.new(msg: request.msg)
    end
  end
end
