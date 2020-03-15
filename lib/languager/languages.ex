defmodule Languager.Languages do
  @moduledoc """
  The Languages context.
  """

  import Ecto.Query, warn: false
  alias Languager.Repo

  alias Languager.Languages.Language

  @doc """
  Returns the list of languages.

  ## Examples

      iex> list_languages()
      [%Language{}, ...]

  """
  def list_languages do
    Repo.all(Language)
  end

  @doc """
  Gets a single language.

  Raises `Ecto.NoResultsError` if the Language does not exist.

  ## Examples

      iex> get_language!(123)
      %Language{}

      iex> get_language!(456)
      ** (Ecto.NoResultsError)

  """
  def get_language(external_id) do
    (from m in Language,
     where: m.external_id == ^external_id)
    |> Languager.Repo.get
  end

  @doc """
  Gets a single language by external_id.

  Returns nil if the Language does not exist.

  ## Examples

      iex> get_language_by_external_id("spanish")
      %User{}

      iex> get_language_by_external_id("fake-language")
      ** nil

  """
  def get_language_by_external_id(external_id) do
    query = (from m in Language,
             where: m.external_id == ^external_id)
    
    case Repo.one(query) do
      nil -> {:error, :not_found}
      val -> {:ok, val}
    end
  end

  @doc """
  Creates a language.

  ## Examples

      iex> create_language(%{field: value})
      {:ok, %Language{}}

      iex> create_language(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_language(attrs \\ %{}) do
    %Language{}
    |> Language.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a language.

  ## Examples

      iex> update_language(language, %{field: new_value})
      {:ok, %Language{}}

      iex> update_language(language, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_language(%Language{} = language, attrs) do
    language
    |> Language.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a language.

  ## Examples

      iex> delete_language(language)
      {:ok, %Language{}}

      iex> delete_language(language)
      {:error, %Ecto.Changeset{}}

  """
  def delete_language(%Language{} = language) do
    Repo.delete(language)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking language changes.

  ## Examples

      iex> change_language(language)
      %Ecto.Changeset{source: %Language{}}

  """
  def change_language(%Language{} = language) do
    Language.changeset(language, %{})
  end
end
