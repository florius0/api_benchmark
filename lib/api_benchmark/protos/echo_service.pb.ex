defmodule ApiBenchmark.Protos.EchoService.Service do
  @moduledoc false
  use GRPC.Service, name: "EchoService", protoc_gen_elixir_version: "0.10.0"

  rpc :Echo, ApiBenchmark.Protos.EchoRequest, ApiBenchmark.Protos.EchoResponse
end

defmodule ApiBenchmark.Protos.EchoService.Stub do
  @moduledoc false
  use GRPC.Stub, service: ApiBenchmark.Protos.EchoService.Service
end