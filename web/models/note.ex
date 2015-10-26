defmodule FsDev.Note do
  use FsDev.Web, :model

  alias FsDev.Tag
  alias FsDev.NoteTag

  schema "notes" do
    field :title, :string
    field :url, :string

    has_many :note_tags, FsDev.NoteTag
    has_many :tags, through: [:note_tags, :tag]

    timestamps
  end

  @required_fields ~w(title url)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
