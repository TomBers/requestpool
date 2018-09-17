defmodule SingleProcess do

  def emitter do
    :timer.sleep(Enum.random(100..1000))
    case Enum.random(0..10) > 5 do
      true -> {:error}
      false -> {:ok}
    end
  end

  def make_request(n, iter) do
    IO.puts("Process #{n} - iteration #{iter}")
    this_iter = iter + 1
    case emitter() do
      {:error} -> make_request(n, this_iter)
      {:ok} -> IO.puts("#{n} - Finished")
    end
  end

  def make_task_request do
    1..5
    |> Enum.map(fn(x) -> Task.async(fn -> make_request(x, 0) end) end)
    |> Enum.map(fn(task) -> Task.await(task) end)
  end

  def make_process_request do
    1..1000
    |> Enum.each(fn(x) -> spawn_link(fn -> make_request(x, 0) end) end)
  end

  def time_task do
    case :timer.tc(fn -> make_task_request() end) do
      {time, _} -> calc_time_from_microseconds(time)
    end
  end

  def time_request do
    case :timer.tc(fn -> make_process_request() end) do
      {time, _} -> calc_time_from_microseconds(time)
    end
  end

  def calc_time_from_microseconds(time) do
    IO.puts("#{time/1000000} seconds")
  end

end
