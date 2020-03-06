defmodule LanguagerWeb.Plugs.LoadCurrentUser do
  def init(default), do: default

  def call(conn, _default) do
    case load_current_user(conn) do
      nil ->
        conn
      user ->
        conn
        |> Plug.Conn.assign(:current_user, user)
    end
  end

  defp load_current_user(conn) do
    # id = Plug.Conn.get_session(conn, :user_id)
    # if id do
    #   Languager.Repo.get(Languager.Accounts.User, id) # |> Maintenance.Repo.preload(:account)
    # end
    nil
  end
end
