defmodule Languager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :encrypted_password, :string
      add :external_id, :string
      add :access_level, :integer
      add :name, :string
      add :phone, :string
      add :address, :string
      add :city, :string
      add :state, :string
      add :postal, :string
      add :country, :string
      add :deleted_at, :utc_datetime
      add :remember_created_at, :utc_datetime
      add :sign_in_count, :integer
      add :current_sign_in_at, :utc_datetime
      add :last_sign_in_at, :utc_datetime
      add :current_sign_in_ip, :string
      add :last_sign_in_ip, :string
      add :confirmed_at, :utc_datetime
      add :unconfirmed_email, :string
      add :unconfirmed_phone, :string
      add :phone_confirmed_at, :utc_datetime
      add :failed_attempts, :integer
      add :locked_at, :utc_datetime
      add :timezone, :string
      add :date_format, :string

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:external_id])
  end
end
