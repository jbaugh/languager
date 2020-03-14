defmodule Languager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :access_level, :integer, default: 0
    field :address, :string
    field :city, :string
    field :confirmed_at, :utc_datetime
    field :country, :string, default: "USA"
    field :current_sign_in_at, :utc_datetime
    field :current_sign_in_ip, :string
    field :deleted_at, :utc_datetime
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true
    field :old_password, :string, virtual: true
    field :failed_attempts, :integer
    field :last_sign_in_at, :utc_datetime
    field :last_sign_in_ip, :string
    field :locked_at, :utc_datetime
    field :name, :string
    field :phone, :string
    field :phone_confirmed_at, :utc_datetime
    field :postal, :string
    field :remember_created_at, :utc_datetime
    field :sign_in_count, :integer
    field :external_id, :string
    field :state, :string
    field :timezone, :string, default: "America/Los_Angeles"
    field :date_format, :string, default: "{0M}/{0D}/{YYYY}"
    field :unconfirmed_email, :string
    field :unconfirmed_phone, :string

    has_many :auth_tokens, Languager.Accounts.AuthToken

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :encrypted_password, :deleted_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :confirmed_at, :unconfirmed_email, :phone, :unconfirmed_phone, :phone_confirmed_at, :failed_attempts, :locked_at, :external_id, :access_level, :name, :address, :city, :state, :postal, :country, :timezone])
  end

  @doc false
  def register_changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :name, :address, :city, :state, :postal, :country, :timezone])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
    |> hash_password()
    |> unique_constraint(:email)
    |> Languager.Services.Sluggify.sluggify(Languager.Accounts.User, :email)
  end

  @doc false
  def update_changeset(user, attrs) do
    user
    |> cast(attrs, [:unconfirmed_email, :unconfirmed_phone, :name, :timezone])
  end

  @doc false
  def password_changeset(user, attrs) do
    user
    |> cast(attrs, [:password, :old_password])
    |> validate_confirmation(:password)
  end

  @doc false
  defp hash_password(%{valid?: false} = changeset), do: changeset
  defp hash_password(%{valid?: true} = changeset) do
    hashed_password =
      changeset
      |> get_field(:password)
      |> Argon2.hash_pwd_salt()

    changeset
    |> put_change(:encrypted_password, hashed_password)
    |> put_change(:password, nil)
  end
end
