defmodule FsDev.Tag do
  use FsDev.Web, :model

  schema "tags" do
    field :name, :string
    field :ref_count, :integer

    timestamps
  end

  @required_fields ~w(name ref_count)
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
