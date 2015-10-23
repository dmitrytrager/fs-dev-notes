defmodule FsDev.TagController do
  use FsDev.Web, :controller

  def index(conn, _params) do
    conn
      |> put_flash(:info, "Welcome to Phoenix, from flash info!")
      |> render("index.html")
  end

  def show(conn, %{"tag" => tag}) do
    render conn, "show.html", tag: tag
  end
end
