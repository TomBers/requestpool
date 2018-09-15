defmodule RequestpoolWeb.PageController do
  use RequestpoolWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
