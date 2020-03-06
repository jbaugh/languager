defmodule LanguagerWeb.LayoutView do
  use LanguagerWeb, :view

  def nav_link(conn, path, display) do
    if String.contains?(conn.request_path, path) do
      raw("<a class=\"inline-block py-2 px-4 text-primary no-underline border-b-2 border-transparent hover:text-primary-dark hover:border-primary\" href=\"#{path}\">#{display}</a>")
    else
      raw("<a class=\"inline-block py-2 px-4 text-primary no-underline border-b-2 border-transparent hover:text-primary-dark hover:border-primary\" href=\"#{path}\">#{display}</a>")
    end
  end
end
