defmodule FsDev.Repo.Migrations.CreateNoteTag do
  use Ecto.Migration

  def change do
    create table(:note_tags) do
      add :note_id, references(:notes)
      add :tag_id, references(:tags)

      timestamps
    end

    create index(:note_tags, [:note_id])
    create index(:note_tags, [:tag_id])
  end
end
