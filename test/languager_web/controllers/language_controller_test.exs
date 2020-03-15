defmodule LanguagerWeb.LanguageControllerTest do
  use LanguagerWeb.ConnCase
  alias Languager.Languages

  @create_attrs %{
    active: true,
    name: "some name"
  }
  @update_attrs %{
    active: false,
    name: "some updated name"
  }
  @invalid_attrs %{active: nil, external_id: nil, name: nil}

  def fixture(:language) do
    {:ok, language} = Languages.create_language(@create_attrs)
    language
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all languages", %{conn: conn} do
      conn = get(conn, Routes.language_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create language" do
    test "renders language when data is valid", %{conn: conn} do
      conn = post(conn, Routes.language_path(conn, :create), language: @create_attrs)
      assert %{"external_id" => external_id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.language_path(conn, :show, external_id))

      assert %{
               "active" => true,
               "external_id" => "some-name",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.language_path(conn, :create), language: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update language" do
    setup [:create_language]

    test "renders language when data is valid", %{conn: conn, language: language} do
      conn = put(conn, Routes.language_path(conn, :update, language), language: @update_attrs)
      assert %{"external_id" => new_external_id} = json_response(conn, 200)["data"]
      conn = get(conn, Routes.language_path(conn, :show, new_external_id))

      assert %{
               "active" => false,
               "external_id" => new_external_id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, language: language} do
      conn = put(conn, Routes.language_path(conn, :update, language), language: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete language" do
    setup [:create_language]

    test "deletes chosen language", %{conn: conn, language: language} do
      conn = delete(conn, Routes.language_path(conn, :delete, language))
      assert response(conn, 204)

      new_conn = get(conn, Routes.language_path(conn, :show, language))
      assert response(new_conn, 404)
    end
  end

  defp create_language(_) do
    language = fixture(:language)
    {:ok, language: language}
  end
end
