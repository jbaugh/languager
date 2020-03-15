defmodule Languager.LanguagesTest do
  use Languager.DataCase

  alias Languager.Languages

  describe "languages" do
    alias Languager.Languages.Language

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def language_fixture(attrs \\ %{}) do
      {:ok, language} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Languages.create_language()

      language
    end

    test "list_languages/0 returns all languages" do
      language = language_fixture()
      assert Languages.list_languages() == [language]
    end

    test "get_language/1 returns the language with given id" do
      language = language_fixture()
      assert Languages.get_language(language.external_id) == {:ok, language}
    end

    test "create_language/1 with valid data creates a language" do
      assert {:ok, %Language{} = language} = Languages.create_language(@valid_attrs)
      assert language.name == "some name"
    end

    test "create_language/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Languages.create_language(@invalid_attrs)
    end

    test "update_language/2 with valid data updates the language" do
      language = language_fixture()
      assert {:ok, %Language{} = language} = Languages.update_language(language, @update_attrs)
      assert language.name == "some updated name"
    end

    test "update_language/2 with invalid data returns error changeset" do
      language = language_fixture()
      assert {:error, %Ecto.Changeset{}} = Languages.update_language(language, @invalid_attrs)
      assert {:ok, language} == Languages.get_language(language.external_id)
    end

    test "delete_language/1 deletes the language" do
      language = language_fixture()
      assert {:ok, %Language{}} = Languages.delete_language(language)
      assert Languages.get_language(language.external_id) == {:error, :not_found}
    end

    test "change_language/1 returns a language changeset" do
      language = language_fixture()
      assert %Ecto.Changeset{} = Languages.change_language(language)
    end
  end
end
