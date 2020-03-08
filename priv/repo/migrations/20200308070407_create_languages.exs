defmodule Languager.Repo.Migrations.CreateLanguages do
  use Ecto.Migration

  def change do
    create table(:languages) do
      add :name, :string
      add :active, :boolean, default: true

      timestamps()
    end
  end
end
