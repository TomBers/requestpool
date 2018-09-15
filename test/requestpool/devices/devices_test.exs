defmodule Requestpool.DevicesTest do
  use Requestpool.DataCase

  alias Requestpool.Devices

  describe "smartplugs" do
    alias Requestpool.Devices.SmartPlug

    @valid_attrs %{name: "some name", request_id: 42}
    @update_attrs %{name: "some updated name", request_id: 43}
    @invalid_attrs %{name: nil, request_id: nil}

    def smart_plug_fixture(attrs \\ %{}) do
      {:ok, smart_plug} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Devices.create_smart_plug()

      smart_plug
    end

    test "list_smartplugs/0 returns all smartplugs" do
      smart_plug = smart_plug_fixture()
      assert Devices.list_smartplugs() == [smart_plug]
    end

    test "get_smart_plug!/1 returns the smart_plug with given id" do
      smart_plug = smart_plug_fixture()
      assert Devices.get_smart_plug!(smart_plug.id) == smart_plug
    end

    test "create_smart_plug/1 with valid data creates a smart_plug" do
      assert {:ok, %SmartPlug{} = smart_plug} = Devices.create_smart_plug(@valid_attrs)
      assert smart_plug.name == "some name"
      assert smart_plug.request_id == 42
    end

    test "create_smart_plug/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Devices.create_smart_plug(@invalid_attrs)
    end

    test "update_smart_plug/2 with valid data updates the smart_plug" do
      smart_plug = smart_plug_fixture()
      assert {:ok, smart_plug} = Devices.update_smart_plug(smart_plug, @update_attrs)
      assert %SmartPlug{} = smart_plug
      assert smart_plug.name == "some updated name"
      assert smart_plug.request_id == 43
    end

    test "update_smart_plug/2 with invalid data returns error changeset" do
      smart_plug = smart_plug_fixture()
      assert {:error, %Ecto.Changeset{}} = Devices.update_smart_plug(smart_plug, @invalid_attrs)
      assert smart_plug == Devices.get_smart_plug!(smart_plug.id)
    end

    test "delete_smart_plug/1 deletes the smart_plug" do
      smart_plug = smart_plug_fixture()
      assert {:ok, %SmartPlug{}} = Devices.delete_smart_plug(smart_plug)
      assert_raise Ecto.NoResultsError, fn -> Devices.get_smart_plug!(smart_plug.id) end
    end

    test "change_smart_plug/1 returns a smart_plug changeset" do
      smart_plug = smart_plug_fixture()
      assert %Ecto.Changeset{} = Devices.change_smart_plug(smart_plug)
    end
  end
end
