defmodule Timebomb do
  use GenServer

  @moduledoc """
  Documentation for `Timebomb`.

  ETS backed delayed action scheduler.

  #TODO: Disarm functionality using ID
  #TODO: Tests
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
    [id: id, fuse: fuse_time, bomb: bomb] = opts
    code = :erlang.term_to_binary(bomb) |> Base.url_encode64()
    :ets.insert(@table, {id, code})
    :timer.send_after(fuse_time, self(), {:explode, id})

    {:noreply, state}
  end

  def handle_info({:explode, id}, state) do
    case find_payload(id) do
      [{_, payload}] ->
        {:ok, code} = payload |> Base.url_decode64()

        code
        |> :erlang.binary_to_term()
        |> IO.inspect()

      [] ->
        nil
    end

    {:noreply, state}
  end

  def handle_cast({:disarm, id}, state) do
    case :ets.delete(@table, id) do
      true ->
        IO.puts("Payload disarmed")

      false ->
        IO.puts("Unable to disarm")
    end

    {:noreply, state}
  end

  defp find_payload(id) do
    :ets.lookup(@table, id)
  end

  def spark(opts) do
    id = opts[:id] || UUID.uuid4()
    opts = Keyword.put(opts, :id, id)

    GenServer.cast(__MODULE__, {:spark, opts})
    id
  end

  def disarm(id) do
    GenServer.cast(__MODULE__, {:disarm, id})
  end
end
