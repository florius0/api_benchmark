defmodule ApiBenchmark.MixProject do
  use Mix.Project

  def project do
    [
      app: :api_benchmark,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {ApiBenchmark, []}
    ]
  end

  defp deps do
    [
      {:grpc, github: "elixir-grpc/grpc"},
      {:protobuf, "~> 0.10.0"},
      {:cowlib, "~> 2.11.0", override: true}
    ]
  end
end
