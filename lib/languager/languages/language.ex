defmodule Languager.Languages.Language do
  use Ecto.Schema
  import Ecto.Changeset

  schema "languages" do
    field :name, :string
    field :active, :boolean, default: true
    field :external_id, :string

    timestamps()
  end

  @doc false
  def changeset(language, attrs) do
    language
    |> cast(attrs, [:name, :active])
    |> validate_required([:name])
    |> set_external_id
  end

  @doc false
  defp set_external_id(%{valid?: false} = changeset), do: changeset
  defp set_external_id(changeset) do
    name = get_field(changeset, :name)

    external_id = 
      name
      |> String.downcase
      |> String.replace(" ", "-")
      |> String.replace(~r/[^0-9a-z\-]/, "")
    put_change(changeset, :external_id, external_id)
  end
end
