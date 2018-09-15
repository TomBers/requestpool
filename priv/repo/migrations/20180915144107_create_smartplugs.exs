defmodule Requestpool.Repo.Migrations.CreateSmartplugs do
  use Ecto.Migration

  def change do
    create table(:smartplugs) do
      add :name, :string
      add :request_id, :integer

      timestamps()
    end

  end
end
