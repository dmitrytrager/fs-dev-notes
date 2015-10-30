defmodule FsDev.NoteController do
  use FsDev.Web, :controller
  require Logger

  alias FsDev.Note
  alias FsDev.Tag
  alias FsDev.NoteTag

  plug :find_tag when action in [:index]
  plug :prepare_tags when action in [:create]
  plug :scrub_params, "note" when action in [:create]

  def index(conn, _params) do
    tag = conn.assigns.tag
    notes = Repo.all assoc(tag, :notes)

    render(conn, "index.html", notes: notes, tag: tag)
  end

  # def new(conn, _params) do
  #   changeset = Note.changeset(%Note{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  def create(conn, %{"note" => note_params}) do
    changeset = Note.changeset(%Note{}, note_params)

    case Repo.insert(changeset) do
      {:ok, note} ->
        tag_ids = conn.assigns.tag_ids
        for tag_id <- tag_ids do
          note_tag = NoteTag.changeset(%NoteTag{}, %{tag_id: tag_id, note_id: note.id})

          if note_tag.valid?, do: Repo.insert(note_tag)
        end

        conn
        |> put_flash(:info, "Note created successfully.")
        |> redirect(to: tag_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    note = Repo.get!(Note, id)
    render(conn, "show.html", note: note)
  end

  # def edit(conn, %{"id" => id}) do
  #   note = Repo.get!(Note, id)
  #   changeset = Note.changeset(note)
  #   render(conn, "edit.html", note: note, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "note" => note_params}) do
  #   note = Repo.get!(Note, id)
  #   changeset = Note.changeset(note, note_params)

  #   case Repo.update(changeset) do
  #     {:ok, note} ->
  #       conn
  #       |> put_flash(:info, "Note updated successfully.")
  #       |> redirect(to: note_path(conn, :show, note))
  #     {:error, changeset} ->
  #       render(conn, "edit.html", note: note, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   note = Repo.get!(Note, id)

  #   # Here we use delete! (with a bang) because we expect
  #   # it to always work (and if it does not, it will raise).
  #   Repo.delete!(note)

  #   conn
  #   |> put_flash(:info, "Note deleted successfully.")
  #   |> redirect(to: note_path(conn, :index))
  # end

  defp find_tag(conn, _) do
    tag = Repo.get(Tag, conn.params["tag_id"])
    assign(conn, :tag, tag)
  end

  defp prepare_tags(conn, _) do
    %{"note" => %{"tag_list" => tag_list}} = conn.params

    tag_ids =
      String.split(String.strip(tag_list), ",") |> Enum.map(&(String.strip(&1))) |> Enum.map(fn tag_title ->
        case Repo.get_by(Tag, name: tag_title) do
          nil ->
            case Repo.insert(Tag.changeset(%Tag{}, %{name: tag_title, ref_count: 1})) do
              {:ok, tag} ->
                tag.id
            end
          tag ->
            case Repo.update(Tag.changeset(tag, %{ref_count: tag.ref_count + 1})) do
              {:ok, tag} ->
                tag.id
            end
        end
      end)

    assign(conn, :tag_ids, tag_ids)
  end
end
