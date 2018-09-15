defmodule Requestpool do

  @url "http://localhost:4000/api/smartplugs"
  @bad_url "http://localhost:4000/ipa/smartplugs"

  def call_api do
    response = HTTPoison.get!(@url)
    req = Poison.decode!(response.body)
    req["data"]
  end

  def call_full do
    case HTTPoison.get(@bad_url) do
      {:ok, %{status_code: 200, body: body}} -> Poison.decode!(body)
      {:ok, %{status_code: 404}} -> {:error}
      {:error, %{reason: reason}} -> {:error}
    end
  end

  def handle_request_error(task) do
    IO.puts("got error")
    Task.shutdown(task, :brutal_kill)
    :timer.sleep(3000)
#    supervise_request()
  end

  def supervise_request do
    {:ok, pid} = Task.Supervisor.start_link()
    task = Task.Supervisor.async(pid, fn ->
      call_full()
    end)
    case Task.await(task) do
      {:error} -> handle_request_error(task)
      data -> data
    end
  end

#  1..3 |> Enum.each(fn(x) -> Requestpool.supervise_request() end)
end
