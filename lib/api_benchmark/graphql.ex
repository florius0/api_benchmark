defmodule  ApiBenchmark.GraphQL.ContentTypes do
  use Absinthe.Schema.Notation

  object :echo do
    field :msg, :string
  end
end

defmodule  ApiBenchmark.GraphQL.Schema do
  use Absinthe.Schema
  import_types ApiBenchmark.GraphQL.ContentTypes

  query do
    field :echo, :echo do
      arg :msg, :string
      resolve fn args, _ -> {:ok, args} end
    end
  end
end

defmodule ApiBenchmark.GraphQL do
  use Plug.Router

  def child_spec(opts \\ Application.fetch_env!(:api_benchmark, :graphql)) do
    port = Keyword.get(opts, :port, 4003)

    Supervisor.child_spec(
      {Plug.Cowboy, scheme: :http, plug: __MODULE__, options: [port: port]},
      id: __MODULE__
    )
  end

  plug :match

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Jason

  plug :dispatch

  forward "/graphiql",
    to: Absinthe.Plug.GraphiQL,
    init_opts: [
      schema: __MODULE__.Schema,
      interface: :playground
    ]

  forward "/api",
    to: Absinthe.Plug,
    init_opts: [schema: __MODULE__.Schema]
end
