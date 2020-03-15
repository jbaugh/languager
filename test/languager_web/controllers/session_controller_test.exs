defmodule LanguagerWeb.SessionControllerTest do
  use LanguagerWeb.ConnCase

  alias Languager.Languages
  alias Languager.Languages.Language

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create" do
    test "signs in the user with proper credentials", %{conn: conn} do
      user = user_fixture
      conn = post(conn, Routes.session_path(conn, :create), %{email: user.email, password: "123123"})
      assert json_response(conn, 200)["data"] == []
    end
  end

end
