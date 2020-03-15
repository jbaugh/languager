defmodule LanguagerWeb.SessionController do
  use LanguagerWeb, :controller
  alias Languager.Accounts.User
  plug LanguagerWeb.Plugs.RequireLoggedIn when action in [:delete]
  plug LanguagerWeb.Plugs.RequireNotLoggedIn when action not in [:delete]

  def create(conn, %{"session" => %{"password" => ""}}) do
    conn
    |> send_resp(401, gettext("Please fill in an email and password."))
  end

  def create(conn, %{"session" => %{"email" => ""}}) do
    conn
    |> send_resp(401, gettext("Please fill in an email and password."))
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case verify_credentials(email, password) do
      {:ok, user} ->
        conn
        |> put_status(:ok)
        |> render("show.json", user)
      {:error, _reason} ->
        conn
        |> send_resp(401, gettext("Invalid email or password."))
    end
  end

  def delete(conn, _params) do
    Languager.Services.Authenticator.delete_token(conn)
    conn
    |> send_resp(204, "")
  end


  defp verify_credentials(email, password) when is_binary(email) and is_binary(password) do
    with {:ok, user} <- find_by_email(email),
      do: verify_password(password, user)
  end

  defp find_by_email(email) when is_binary(email) do
    case Languager.Repo.get_by(User, email: email) do
      nil ->
        Argon2.no_user_verify()
        {:error, gettext("User with email '%{name}' not found", name: email)}
      user ->
        {:ok, user}
    end
  end

  defp verify_password(password, %User{} = user) when is_binary(password) do
    if Argon2.verify_pass(password, user.encrypted_password) do
      token = Languager.Services.Authenticator.generate_token(user.id)
      Languager.Repo.insert(Ecto.build_assoc(user, :auth_tokens, %{token: token}))
      {:ok, user}
    else
      {:error, :invalid_password}
    end
  end
end
