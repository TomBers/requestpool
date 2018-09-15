defmodule RequestpoolWeb.SmartPlugControllerTest do
  use RequestpoolWeb.ConnCase

  alias Requestpool.Devices
  alias Requestpool.Devices.SmartPlug

  @create_attrs %{name: "some name", request_id: 42}
  @update_attrs %{name: "some updated name", request_id: 43}
  @invalid_attrs %{name: nil, request_id: nil}

  def fixture(:smart_plug) do
    {:ok, smart_plug} = Devices.create_smart_plug(@create_attrs)
    smart_plug
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all smartplugs", %{conn: conn} do
      conn = get conn, smart_plug_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create smart_plug" do
    test "renders smart_plug when data is valid", %{conn: conn} do
      conn = post conn, smart_plug_path(conn, :create), smart_plug: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, smart_plug_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some name",
        "request_id" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, smart_plug_path(conn, :create), smart_plug: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update smart_plug" do
    setup [:create_smart_plug]

    test "renders smart_plug when data is valid", %{conn: conn, smart_plug: %SmartPlug{id: id} = smart_plug} do
      conn = put conn, smart_plug_path(conn, :update, smart_plug), smart_plug: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, smart_plug_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some updated name",
        "request_id" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, smart_plug: smart_plug} do
      conn = put conn, smart_plug_path(conn, :update, smart_plug), smart_plug: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete smart_plug" do
    setup [:create_smart_plug]

    test "deletes chosen smart_plug", %{conn: conn, smart_plug: smart_plug} do
      conn = delete conn, smart_plug_path(conn, :delete, smart_plug)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, smart_plug_path(conn, :show, smart_plug)
      end
    end
  end

  defp create_smart_plug(_) do
    smart_plug = fixture(:smart_plug)
    {:ok, smart_plug: smart_plug}
  end
end
