defmodule LanguagerWeb.Plugs.RequireLoggedIn do
  import Plug.Conn
  import Phoenix.Controller
  import LanguagerWeb.Gettext
  require Logger

  def init(default), do: default

  def call(conn, _default) do
    Logger.info "IN RequireLoggedIn"
    case conn.assigns[:current_user] do
      nil ->
        conn
        |> put_status(:unauthorized)
        |> put_view(LanguagerWeb.ErrorView)
        |> render("error.json", %{message: gettext("You are not authorized to access this")})
        |> halt
      _user_id ->
        conn
    end
  end
end
