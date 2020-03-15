defmodule LanguagerWeb.ErrorView do
  use LanguagerWeb, :view

  def render("error.json", %{message: message}) do
    %{error: message}
  end
end
