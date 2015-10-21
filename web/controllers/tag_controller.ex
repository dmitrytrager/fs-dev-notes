defmodule FsDev.TagController do
  use FsDev.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, %{"tag" => tag}) do
    render conn, "show.html", tag: tag
  end
end
