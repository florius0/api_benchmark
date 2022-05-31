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
      {:protobuf, "~> 0.10"},
      {:cowlib, "~> 2.11", override: true},
      {:absinthe, "~> 1.7"},
      {:absinthe_plug, "~> 1.5"},
      {:plug_cowboy, "~> 2.5"},
      {:jason, "~> 1.3"}
    ]
  end
end
