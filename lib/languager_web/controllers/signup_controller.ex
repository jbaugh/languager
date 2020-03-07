defmodule LanguagerWeb.SignupController do
  use LanguagerWeb, :controller
  alias Languager.Accounts.{User}
  plug LanguagerWeb.Plugs.RequireNotLoggedIn

  def new(conn, _params) do
    changeset = User.register_changeset(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Languager.Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, gettext("You have successfully signed up!"))
        |> login_user(user)
        |> redirect(to: "/")

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
