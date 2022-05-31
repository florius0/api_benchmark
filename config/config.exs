import Config

config :api_benchmark, ApiBenchmark.Tcp, port: 4000

config :api_benchmark, ApiBenchmark.Udp, port: 4001

config :api_benchmark, ApiBenchmark.Grpc, port: 4002

config :api_benchmark, ApiBenchmark.GraphQL,
  http: [port: 4003],
  server: true,
  debug_errors: true,
  pubsub_server: ApiBenchmark.PubSub

config :api_benchmark, ApiBenchmark.RestOverHttp, port: 4004

config :grpc, start_server: true
config :phoenix, :json_library, Jason
