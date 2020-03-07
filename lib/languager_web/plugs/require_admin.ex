defmodule LanguagerWeb.Plugs.RequireAdmin do
  import Plug.Conn
  import Phoenix.Controller
  import LanguagerWeb.Gettext
  require Logger

  def init(default), do: default

  def call(conn, _default) do
    Logger.info "IN RequireAdmin"
    case Plug.Conn.get_session(conn, :current_user) do
      nil ->
        conn
        |> put_flash(:error, gettext("You need to be logged in."))
        |> redirect(to: "/login")
        |> halt
      user ->
        if user.access_level > 999 do
          conn
        else
          conn
          |> put_flash(:error, gettext("Not found."))
          |> redirect(to: "/")
          |> halt
        end
    end
  end
end
