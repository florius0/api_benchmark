import Config

config :api_benchmark, :tcp,
  port: 4000

config :api_benchmark, :udp,
  port: 4001

config :grpc, start_server: true

config :api_benchmark, :grpc,
  port: 4002

config :api_benchmark, :graphql,
  port: 4003
