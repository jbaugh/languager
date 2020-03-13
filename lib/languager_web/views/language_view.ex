defmodule LanguagerWeb.LanguageView do
  use LanguagerWeb, :view
  alias LanguagerWeb.LanguageView

  def render("index.json", %{languages: languages}) do
    %{data: render_many(languages, LanguageView, "language.json")}
  end

  def render("show.json", %{language: language}) do
    %{data: render_one(language, LanguageView, "language.json")}
  end

  def render("language.json", %{language: language}) do
    %{id: language.id,
      name: language.name,
      active: language.active,
      external_id: language.external_id}
  end
end
