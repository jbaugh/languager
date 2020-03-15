defmodule Languager.Accounts.AuthToken do
  use Ecto.Schema
  import Ecto.Changeset

  schema "auth_tokens" do
    field :token, :string
    field :token_type, :string
    field :user_id, :id
    field :expires_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(auth_tokens, attrs) do
    auth_tokens
    |> cast(attrs, [:token, :token_type])
    |> validate_required([:token, :token_type])
    |> unique_constraint(:token)
  end

  def login_type do
    'login'
  end
end
