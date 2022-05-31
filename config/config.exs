import Config

config :api_benchmark, :tcp,
  port: 4000

config :api_benchmark, :udp,
  port: 4001

config :grpc, start_server: true

config :api_benchmark, :grpc,
  port: 4002

config :api_benchmark, ApiBenchmark.GraphQL,
  http: [port: 4003],
  server: true,
  debug_errors: true,
  pubsub_server: ApiBenchmark.PubSub

config :phoenix, :json_library, Jason
