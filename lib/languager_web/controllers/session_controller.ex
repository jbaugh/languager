defmodule LanguagerWeb.SessionController do
  use LanguagerWeb, :controller
  alias Languager.Accounts.User
  plug LanguagerWeb.Plugs.RequireLoggedIn when action in [:delete]
  plug LanguagerWeb.Plugs.RequireNotLoggedIn when action not in [:delete]

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"password" => ""}}) do
    conn
    |> render("new.html", error_message: gettext("Please fill in an email and password."))
  end

  def create(conn, %{"session" => %{"email" => ""}}) do
    conn
    |> render("new.html", error_message: gettext("Please fill in an email and password."))
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case verify_credentials(email, password) do
      {:ok, user} ->
        conn
        |> put_flash(:info, gettext("Successfully logged in."))
        |> login_user(user)
        |> redirect(to: "/")
      {:error, _reason} ->
        conn
        |> render("new.html", error_message: gettext("Invalid email or password."))
    end
  end

  def delete(conn, _params) do
    logout(conn)
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
      {:ok, user}
    else
      {:error, :invalid_password}
    end
  end
end
