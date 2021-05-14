defmodule Timebomb do
  use GenServer

  @moduledoc """
  Documentation for `Timebomb`.
  """

  @table :timebomb

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(_) do
    :ets.new(@table, [:named_table, read_concurrency: true])
    {:ok, %{}}
  end

  def handle_cast({:spark, opts}, state) do
    [fuse: fuse_time, bomb: bomb] = opts
    id = opts[:id] || UUID.uuid4()
    code = :erlang.term_to_binary(bomb) |> Base.url_encode64()
    :ets.insert(@table, {id, code})
    :timer.send_after(fuse_time, self(), {:explode, id})

    {:noreply, state}
  end

  def handle_info({:explode, id}, state) do
    [{_, payload}] = :ets.lookup(@table, id)

    {:ok, code} = payload |> Base.url_decode64()

    code
    |> :erlang.binary_to_term()
    |> IO.inspect()

    {:noreply, state}
  end

  def spark(opts) do
    GenServer.cast(__MODULE__, {:spark, opts})
  end
end
