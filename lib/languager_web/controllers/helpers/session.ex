defmodule LanguagerWeb.Helpers.Session do
  import Phoenix.Controller
  import LanguagerWeb.Gettext

  def login_user(conn, user) do
    conn
    |> Plug.Conn.put_session(:user_id, user.id)
    |> Plug.Conn.assign(:current_user, user)
  end

  def logout(conn), do: logout(conn, gettext("You have been logged out."))
  def logout(conn, message) do
    conn
    |> Plug.Conn.delete_session(:user_id)
    |> Plug.Conn.assign(:current_user, nil)
    |> put_flash(:info, message)
    |> redirect(to: "/")
  end

  def current_user(conn) do
    conn.assigns[:current_user]
  end

  def logged_in?(conn) do
    case current_user(conn) do
      nil ->
        false
      _response ->
        true
    end
  end
end
