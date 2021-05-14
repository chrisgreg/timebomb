defmodule TimebombTest do
  use ExUnit.Case
  doctest Timebomb

  test "greets the world" do
    assert Timebomb.hello() == :world
  end
end
