defmodule LanguagerWeb.Plugs.RequireNotLoggedIn do
  import Plug.Conn
  import Phoenix.Controller

  def init(default), do: default

  def call(conn, _default) do
    case Plug.Conn.get_session(conn, :user_id) do
      nil ->
        conn
      _user ->
        conn
        |> redirect(to: "/dashboard")
        |> halt
    end
  end
end
