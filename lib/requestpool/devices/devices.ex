defmodule Requestpool.Devices do
  @moduledoc """
  The Devices context.
  """

  import Ecto.Query, warn: false
  alias Requestpool.Repo

  alias Requestpool.Devices.SmartPlug

  @doc """
  Returns the list of smartplugs.

  ## Examples

      iex> list_smartplugs()
      [%SmartPlug{}, ...]

  """
  def list_smartplugs do
    Repo.all(SmartPlug)
  end

  @doc """
  Gets a single smart_plug.

  Raises `Ecto.NoResultsError` if the Smart plug does not exist.

  ## Examples

      iex> get_smart_plug!(123)
      %SmartPlug{}

      iex> get_smart_plug!(456)
      ** (Ecto.NoResultsError)

  """
  def get_smart_plug!(id), do: Repo.get!(SmartPlug, id)

  @doc """
  Creates a smart_plug.

  ## Examples

      iex> create_smart_plug(%{field: value})
      {:ok, %SmartPlug{}}

      iex> create_smart_plug(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_smart_plug(attrs \\ %{}) do
    %SmartPlug{}
    |> SmartPlug.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a smart_plug.

  ## Examples

      iex> update_smart_plug(smart_plug, %{field: new_value})
      {:ok, %SmartPlug{}}

      iex> update_smart_plug(smart_plug, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_smart_plug(%SmartPlug{} = smart_plug, attrs) do
    smart_plug
    |> SmartPlug.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a SmartPlug.

  ## Examples

      iex> delete_smart_plug(smart_plug)
      {:ok, %SmartPlug{}}

      iex> delete_smart_plug(smart_plug)
      {:error, %Ecto.Changeset{}}

  """
  def delete_smart_plug(%SmartPlug{} = smart_plug) do
    Repo.delete(smart_plug)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking smart_plug changes.

  ## Examples

      iex> change_smart_plug(smart_plug)
      %Ecto.Changeset{source: %SmartPlug{}}

  """
  def change_smart_plug(%SmartPlug{} = smart_plug) do
    SmartPlug.changeset(smart_plug, %{})
  end
end
