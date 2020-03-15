defmodule LanguagerWeb.LanguageController do
  use LanguagerWeb, :controller
  alias Languager.Languages
  alias Languager.Languages.Language

  action_fallback LanguagerWeb.FallbackController

  def index(conn, _params) do
    languages = Languages.list_languages()
    render(conn, "index.json", languages: languages)
  end

  def create(conn, %{"language" => language_params}) do
    with {:ok, %Language{} = language} <- Languages.create_language(language_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.language_path(conn, :show, language))
      |> render("show.json", language: language)
    end
  end

  # curl http://localhost:4000/api/v1/languages/1 -H "Content-Type: application/json"
  def show(conn, %{"id" => id}) do
    with {:ok, language} <- Languages.get_language(id) do
      render(conn, "show.json", language: language)
    end
  end

  def update(conn, %{"id" => id, "language" => language_params}) do
    with {:ok, language} <- Languages.get_language(id) do
      with {:ok, %Language{} = language} <- Languages.update_language(language, language_params) do
        render(conn, "show.json", language: language)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, language} <- Languages.get_language(id) do
      with {:ok, %Language{}} <- Languages.delete_language(language) do
        conn
        |> put_status(204)
        |> render("show.json", language: language)
      end
    end
  end
end
