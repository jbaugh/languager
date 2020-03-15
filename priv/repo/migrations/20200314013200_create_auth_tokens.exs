defmodule Languager.Repo.Migrations.CreateAuthTokens do
  use Ecto.Migration

  def change do
    create table(:auth_tokens) do
      add :token, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :expires_at, :utc_datetime

      timestamps()
    end

    create unique_index(:auth_tokens, [:token])
    create index(:auth_tokens, [:user_id])
  end
end
