defmodule FsDev.TagTest do
  use FsDev.ModelCase

  alias FsDev.Tag

  @valid_attrs %{name: "some content", ref_count: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Tag.changeset(%Tag{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Tag.changeset(%Tag{}, @invalid_attrs)
    refute changeset.valid?
  end
end
