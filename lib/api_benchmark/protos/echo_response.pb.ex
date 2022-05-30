defmodule ApiBenchmark.Protos.EchoResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field :msg, 1, type: :string
end