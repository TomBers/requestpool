defmodule Requestpool.Devices.SmartPlug do
  use Ecto.Schema
  import Ecto.Changeset


  schema "smartplugs" do
    field :name, :string
    field :request_id, :integer

    timestamps()
  end

  @doc false
  def changeset(smart_plug, attrs) do
    smart_plug
    |> cast(attrs, [:name, :request_id])
    |> validate_required([:name, :request_id])
  end
end
