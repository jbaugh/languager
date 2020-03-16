defmodule LanguagerWeb.Plugs.RequireAdmin do
  import Plug.Conn
  import Phoenix.Controller
  import LanguagerWeb.Gettext
  require Logger

  def init(default), do: default

  def call(conn, _default) do
    Logger.info "IN RequireAdmin"
    case conn.assigns[:current_user] do
      nil ->
        conn
        |> put_status(:not_found)
        |> put_view(LanguagerWeb.ErrorView)
        |> render("error.json", %{message: gettext("Not found")})
        |> halt
      user ->
        if user.access_level > 999 do
          conn
        else
          conn
          |> put_status(:not_found)
          |> put_view(LanguagerWeb.ErrorView)
          |> render("error.json", %{message: gettext("Not found")})
          |> halt
        end
    end
  end
end
