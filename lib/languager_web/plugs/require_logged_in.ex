defmodule LanguagerWeb.Plugs.RequireLoggedIn do
  import Plug.Conn
  import Phoenix.Controller
  import LanguagerWeb.Gettext
  require Logger

  def init(default), do: default

  def call(conn, _default) do
    Logger.info "IN RequireLoggedIn"
    case Plug.Conn.get_session(conn, :user_id) do
      nil ->
        conn
        |> put_flash(:error, gettext("You need to be logged in."))
        |> redirect(to: "/login")
        |> halt
      _user_id ->
        conn
    end
  end
end
