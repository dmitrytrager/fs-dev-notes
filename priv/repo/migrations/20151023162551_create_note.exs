defmodule FsDev.Repo.Migrations.CreateNote do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :title, :string
      add :url, :string

      timestamps
    end

  end
end
