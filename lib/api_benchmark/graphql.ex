defmodule ApiBenchmark.GraphQL.ContentTypes do
  use Absinthe.Schema.Notation

  object :echo do
    field :msg, :string
  end
end

defmodule ApiBenchmark.GraphQL.Schema do
  use Absinthe.Schema
  import_types ApiBenchmark.GraphQL.ContentTypes

  query do
    field :echo, :echo do
      arg :msg, :string
      resolve fn args, _ -> {:ok, args} end
    end
  end

  mutation do
    field :echo, :echo do
      arg :msg, :string
      resolve fn args, _ -> {:ok, args} end
    end
  end

  subscription do
    field :echo, :echo do
      config fn _, _ -> {:ok, topic: "echo"} end
      trigger :echo, topic: fn _ -> "echo" end
    end
  end
end

defmodule ApiBenchmark.GraphQL do
  use Phoenix.Endpoint, otp_app: :api_benchmark
  use Absinthe.Phoenix.Endpoint

  socket("/socket", __MODULE__.Socket,
    websocket: true,
    longpoll: false
  )

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Jason

  plug Absinthe.Plug.GraphiQL,
    schema: __MODULE__.Schema,
    socket: __MODULE__.Socket,
    interface: :playground
end

defmodule ApiBenchmark.GraphQL.Socket do
  use Phoenix.Socket

  use Absinthe.Phoenix.Socket,
    schema: ApiBenchmark.GraphQL.Schema

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
