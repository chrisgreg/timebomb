# Timebomb

ETS backed delayed action scheduler written in Elixir & Erlang.

Ever wanted to implement something like how UberEats and Deliveroo ping you with a notification if you don't checkout after X time?

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

## Example Usage

Sparking a fuse on an action

```elixir
Timebomb.start_link
{:ok, #PID<0.200.0>}

Timebomb.spark(fuse: 10_000, bomb: 1+5)
  
...10 seconds later

6
```


Stopping a payload from firing

```elixir
Timebomb.start_link
{:ok, #PID<0.200.0>}

id = Timebomb.spark(fuse: 10_000, bomb: 1+5)
"53b45c7f-8bde-4d24-ae99-a6f215bb7104"

Timebomb.disarm(id)
Payload disarmed
:ok
```

## TODO:
- Tests
- Publish on Hex

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/timebomb](https://hexdocs.pm/timebomb).
