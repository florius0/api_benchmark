import Config

config :api_benchmark, :tcp,
  port: 4000

config :api_benchmark, :udp,
  port: 4001

config :grpc, start_server: true
