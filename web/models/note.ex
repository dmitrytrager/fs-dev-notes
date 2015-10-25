defmodule FsDev.Note do
  use FsDev.Web, :model

  schema "notes" do
    field :title, :string
    field :url, :string

    has_many :note_tags, FsDev.NoteTag
    has_many :tags, through: [:note_tags, :tag]

    timestamps
  end

  @required_fields ~w(title url)
  @optional_fields ~w(tags)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  after_insert :update_tags
  def update_tags(changeset) do
    changeset
    |> Ecto.Changeset.put_change(:approved_at, nil)
  end
end
