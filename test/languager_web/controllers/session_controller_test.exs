defmodule LanguagerWeb.SessionControllerTest do
  use LanguagerWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create" do
    test "signs in the user with proper credentials", %{conn: conn} do
      user = user_fixture()
      conn = post(conn, Routes.session_path(conn, :create), %{email: user.email, password: "123123"})
      data = json_response(conn, 200)["data"]
      assert data["name"] == user.name
      assert data["email"] == user.email
      assert data["external_id"] == user.external_id
      refute data["token"] == nil
      refute data["token"] == ""
    end

    test "does not sign in user with missing email", %{conn: conn} do
      conn = post(conn, Routes.session_path(conn, :create), %{password: "123123"})
      response = json_response(conn, 401)
      assert response["data"] == nil
      assert response["error"] == "Please fill in an email and password."
    end

    test "does not sign in user with blank email", %{conn: conn} do
      conn = post(conn, Routes.session_path(conn, :create), %{email: "", password: "123123"})
      response = json_response(conn, 401)
      assert response["data"] == nil
      assert response["error"] == "Please fill in an email and password."
    end

    test "does not sign in user with missing password", %{conn: conn} do
      user = user_fixture()
      conn = post(conn, Routes.session_path(conn, :create), %{email: user.email})
      response = json_response(conn, 401)
      assert response["data"] == nil
      assert response["error"] == "Please fill in an email and password."
    end

    test "does not sign in user with blank password", %{conn: conn} do
      user = user_fixture()
      conn = post(conn, Routes.session_path(conn, :create), %{email: user.email, password: ""})
      response = json_response(conn, 401)
      assert response["data"] == nil
      assert response["error"] == "Please fill in an email and password."
    end

    test "does not sign in user with email with no user", %{conn: conn} do
      conn = post(conn, Routes.session_path(conn, :create), %{email: "some-email@example.com", password: "123123"})
      response = json_response(conn, 401)
      assert response["data"] == nil
      assert response["error"] == "Invalid email or password."
    end

    test "does not sign in user with an invalid password", %{conn: conn} do
      user = user_fixture()
      conn = post(conn, Routes.session_path(conn, :create), %{email: user.email, password: "1111111"})
      response = json_response(conn, 401)
      assert response["data"] == nil
      assert response["error"] == "Invalid email or password."
    end
  end
end
