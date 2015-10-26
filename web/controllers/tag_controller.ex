defmodule FsDev.TagController do
  use FsDev.Web, :controller

  alias FsDev.Tag
  alias FsDev.Note

  def index(conn, _params) do
    tags = Repo.all(Tag)
    new_note = Note.changeset(%Note{})

    render(conn, "index.html", tags: tags, new_note: new_note)
  end

  def show(conn, %{"tag" => tag}) do
    render conn, "show.html", tag: tag
  end
end
