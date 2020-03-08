defmodule Languager.Repo.Migrations.CreateLanguages do
  use Ecto.Migration

  def change do
    create table(:languages) do
      add :name, :string
      add :external_id, :string
      add :active, :boolean, default: true

      timestamps()
    end

    create unique_index(:languages, [:external_id])
  end
end
