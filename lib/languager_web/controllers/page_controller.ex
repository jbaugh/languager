defmodule LanguagerWeb.PageController do
  use LanguagerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
