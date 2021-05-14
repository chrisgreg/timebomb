# Timebomb

ETS backed delayed action scheduler written in Elixir & Erlang.

Ever wanted to implement something like how UberEats and Deliveroo ping you with a notification if you don't checkout after X time?

## Example usage:

```elixir
  timed_function = IO.inspect("BOOM")
  Timebomb.spark(fuse: 10_000, bomb: timed_function)
  
  ...10 seconds later
  BOOM
```

## TODO:
- Tests
- Disarm functionality
- Publish on Hex

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `timebomb` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:timebomb, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/timebomb](https://hexdocs.pm/timebomb).
