defmodule LanguagerWeb.SignupView do
  use LanguagerWeb, :view

  def attribute_name(key) do
    Map.get(%{
      email: gettext("Email"),
      password: gettext("Password")
    }, key, gettext("unknown"))
  end
end
