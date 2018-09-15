defmodule GotRequests do

  def emitter do
    :timer.sleep(Enum.random(100..1000))
    case Enum.random(0..10) > 5 do
      true -> {:error}
      false -> {:ok}
    end
  end

  def many_responses(0) do
    []
  end

  def many_responses(n)  do
    actual_range = n - 1
    0..actual_range
    |> Enum.map(fn(_) -> emitter() end)
  end

  def iter do
    {:ok, pid} = Task.Supervisor.start_link()
    task = Task.Supervisor.async(pid, fn ->
      emitter()
    end)
    Task.await(task)
  end

  def run_multiple_requests do
    1..10
    |> Enum.map(fn(_) -> async_iter() end)
    |> Enum.map(fn(_) -> get_result() end)
    |> remove_errors()
  end

  def get_result do
    receive do
      {:result, result} -> result
    end
  end

  def async_iter do
    caller = self()
    spawn(fn -> send(caller, {:result, iter()}) end)
  end

  def time_multiple_rquests do
    case :timer.tc(fn -> run_multiple_requests() end) do
      {time, _} -> calc_time_from_microseconds(time)
    end
  end

  def calc_time_from_microseconds(time) do
    IO.puts("#{time/1000000} seconds")
  end

  def remove_errors(items) when length(items) == 0 do
    IO.puts("Finished")
  end

  def remove_errors(items) when length(items) > 0 do
    IO.inspect(items)
    items
    |> Enum.filter(fn(x) -> x == {:error} end)
    |> Enum.map(fn(_) -> async_iter() end)
    |> Enum.map(fn(_) -> get_result() end)
    |> remove_errors()
  end

end
