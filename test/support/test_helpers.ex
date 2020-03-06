defmodule Languager.TestHelpers do
  alias Languager.Accounts

  def user_fixture(attrs \\ %{}) do
    params =
      %{
        name: "Howl Pendragon",
        email: "magician#{System.unique_integer([:positive])}@example.com",
        password: "123123"
      } |> Enum.into(attrs)

    {:ok, user} = params |> Accounts.create_user()

    user
  end
end
