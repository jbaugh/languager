defmodule LanguagerWeb.Plugs.RequireNotLoggedIn do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _default) do
    case conn.assigns[:current_user] do
      nil ->
        conn
      _user ->
        conn |> send_resp(302, "/") |> halt()
    end
  end
end
