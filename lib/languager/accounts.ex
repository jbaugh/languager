defmodule Languager.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Languager.Repo

  alias Languager.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.register_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias Languager.Accounts.AuthToken

  @doc """
  Returns the list of auth_tokens.

  ## Examples

      iex> list_auth_tokens()
      [%AuthToken{}, ...]

  """
  def list_auth_tokens do
    Repo.all(AuthToken)
  end

  @doc """
  Gets a single auth_tokens.

  Raises `Ecto.NoResultsError` if the Auth tokens does not exist.

  ## Examples

      iex> get_auth_tokens!(123)
      %AuthToken{}

      iex> get_auth_tokens!(456)
      ** (Ecto.NoResultsError)

  """
  def get_auth_tokens!(id), do: Repo.get!(AuthToken, id)

  @doc """
  Creates a auth_tokens.

  ## Examples

      iex> create_auth_tokens(%{field: value})
      {:ok, %AuthToken{}}

      iex> create_auth_tokens(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_auth_tokens(attrs \\ %{}) do
    %AuthToken{}
    |> AuthToken.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a auth_tokens.

  ## Examples

      iex> update_auth_tokens(auth_tokens, %{field: new_value})
      {:ok, %AuthToken{}}

      iex> update_auth_tokens(auth_tokens, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_auth_tokens(%AuthToken{} = auth_tokens, attrs) do
    auth_tokens
    |> AuthToken.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a auth_tokens.

  ## Examples

      iex> delete_auth_tokens(auth_tokens)
      {:ok, %AuthToken{}}

      iex> delete_auth_tokens(auth_tokens)
      {:error, %Ecto.Changeset{}}

  """
  def delete_auth_tokens(%AuthToken{} = auth_tokens) do
    Repo.delete(auth_tokens)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking auth_tokens changes.

  ## Examples

      iex> change_auth_tokens(auth_tokens)
      %Ecto.Changeset{source: %AuthToken{}}

  """
  def change_auth_tokens(%AuthToken{} = auth_tokens) do
    AuthToken.changeset(auth_tokens, %{})
  end
end
