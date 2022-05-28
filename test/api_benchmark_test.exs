defmodule ApiBenchmarkTest do
  use ExUnit.Case
  doctest ApiBenchmark

  test "greets the world" do
    assert ApiBenchmark.hello() == :world
  end
end
