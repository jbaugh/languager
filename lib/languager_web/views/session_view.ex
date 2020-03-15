defmodule LanguagerWeb.SessionView do
  use LanguagerWeb, :view

  def render("show.json", %{user: _user, token: token}) do
    %{data: %{token: token}}
  end
end
