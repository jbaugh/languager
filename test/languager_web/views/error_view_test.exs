defmodule LanguagerWeb.ErrorViewTest do
  use LanguagerWeb.ConnCase, async: true

  test "renders the error message" do
    assert LanguagerWeb.ErrorView.render("error.json", %{message: "foo"}) == %{error: "foo"}
  end
end
