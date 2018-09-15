defmodule RequestpoolWeb.SmartPlugController do
  use RequestpoolWeb, :controller

  alias Requestpool.Devices
  alias Requestpool.Devices.SmartPlug

  action_fallback RequestpoolWeb.FallbackController

  def index(conn, _params) do
    smartplugs = Devices.list_smartplugs()
    render(conn, "index.json", smartplugs: smartplugs)
  end

  def create(conn, %{"smart_plug" => smart_plug_params}) do
    with {:ok, %SmartPlug{} = smart_plug} <- Devices.create_smart_plug(smart_plug_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", smart_plug_path(conn, :show, smart_plug))
      |> render("show.json", smart_plug: smart_plug)
    end
  end

  def show(conn, %{"id" => id}) do
    smart_plug = Devices.get_smart_plug!(id)
    render(conn, "show.json", smart_plug: smart_plug)
  end

  def update(conn, %{"id" => id, "smart_plug" => smart_plug_params}) do
    smart_plug = Devices.get_smart_plug!(id)

    with {:ok, %SmartPlug{} = smart_plug} <- Devices.update_smart_plug(smart_plug, smart_plug_params) do
      render(conn, "show.json", smart_plug: smart_plug)
    end
  end

  def delete(conn, %{"id" => id}) do
    smart_plug = Devices.get_smart_plug!(id)
    with {:ok, %SmartPlug{}} <- Devices.delete_smart_plug(smart_plug) do
      send_resp(conn, :no_content, "")
    end
  end
end
