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
    case Languager.Services.Authenticator.get_auth_token(conn) do
      {:ok, token} ->
        case Languager.Accounts.get_auth_token(token) |> Repo.preload(:user) do
          nil -> nil
          auth_token -> auth_token.user
        end
      _ -> nil
    end
  end
end
