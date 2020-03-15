defmodule LanguagerWeb.SessionView do
  use LanguagerWeb, :view

  def render("show.json", %{user: user, token: token}) do
    %{data: %{token: token, email: user.email, name: user.name, external_id: user.external_id}}
  end
end
