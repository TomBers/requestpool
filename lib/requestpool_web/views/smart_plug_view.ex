defmodule RequestpoolWeb.SmartPlugView do
  use RequestpoolWeb, :view
  alias RequestpoolWeb.SmartPlugView

  def render("index.json", %{smartplugs: smartplugs}) do
    %{data: render_many(smartplugs, SmartPlugView, "smart_plug.json")}
  end

  def render("show.json", %{smart_plug: smart_plug}) do
    %{data: render_one(smart_plug, SmartPlugView, "smart_plug.json")}
  end

  def render("smart_plug.json", %{smart_plug: smart_plug}) do
    %{id: smart_plug.id,
      name: smart_plug.name,
      request_id: smart_plug.request_id}
  end
end
